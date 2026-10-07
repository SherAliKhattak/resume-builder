import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/constants/section_keys.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/job_description_dao.dart';
import '../../../../core/database/daos/profile_dao.dart';
import '../../../../core/database/daos/settings_dao.dart';
import '../../../../core/utils/json_list.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../../job_description/domain/models/job_description.dart';
import '../../domain/models/profile_models.dart';
import '../../domain/models/resume_data.dart';
import '../../domain/repositories/resume_repository.dart';
import '../mappers/profile_mappers.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  ResumeRepositoryImpl(this._db);

  final AppDatabase _db;

  ProfileDao get _profile => _db.profileDao;
  JobDescriptionDao get _jobs => _db.jobDescriptionDao;
  SettingsDao get _settings => _db.settingsDao;

  @override
  Stream<ResumeData> watchResume() {
    late StreamController<ResumeData> controller;
    final subscriptions = <StreamSubscription<dynamic>>[];
    Timer? debounce;

    Future<void> emit() async {
      if (controller.isClosed) return;
      controller.add(await getResume());
    }

    void schedule() {
      debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 40), emit);
    }

    controller = StreamController<ResumeData>.broadcast(
      onListen: () {
        emit();
        subscriptions.addAll([
          _profile.watchPersonalInfo().listen((_) => schedule()),
          _profile.watchSummary().listen((_) => schedule()),
          _profile.watchExperiences().listen((_) => schedule()),
          _profile.watchEducations().listen((_) => schedule()),
          _profile.watchSkillGroups().listen((_) => schedule()),
          _profile.watchSkills().listen((_) => schedule()),
          _profile.watchCourses().listen((_) => schedule()),
          _profile.watchProjects().listen((_) => schedule()),
          _profile.watchLanguages().listen((_) => schedule()),
          _profile.watchAwards().listen((_) => schedule()),
          _profile.watchCustomSections().listen((_) => schedule()),
          _jobs.watchLatest().listen((_) => schedule()),
          _settings.watch().listen((_) => schedule()),
        ]);
      },
      onCancel: () async {
        debounce?.cancel();
        for (final sub in subscriptions) {
          await sub.cancel();
        }
        subscriptions.clear();
      },
    );

    return controller.stream;
  }

  @override
  Future<ResumeData> getResume() async {
    final personal = personalInfoFromRow(await _profile.getPersonalInfo());
    final summary = await _profile.getSummary();
    final experiences = (await _profile.getExperiences())
        .map(experienceFromRow)
        .toList();
    final educations = (await _profile.getEducations())
        .map(educationFromRow)
        .toList();
    final skillGroups = _assembleSkillGroups(
      await _profile.getSkillGroups(),
      await _profile.getSkills(),
    );
    final courses = (await _profile.getCourses()).map(courseFromRow).toList();
    final projects = (await _profile.getProjects()).map(projectFromRow).toList();
    final languages = (await _profile.getLanguages())
        .map(languageFromRow)
        .toList();
    final awards = (await _profile.getAwards()).map(awardFromRow).toList();
    final custom = (await _profile.getCustomSections())
        .map(customSectionFromRow)
        .toList();
    final job = _jobFromRow(await _jobs.getLatest());
    final settings = _settingsFromRow(await _settings.get());

    return ResumeData(
      personal: personal,
      summary: summary.body,
      experiences: experiences,
      educations: educations,
      skillGroups: skillGroups,
      courses: courses,
      projects: projects,
      languages: languages,
      awards: awards,
      customSections: custom,
      jobDescription: job,
      settings: settings,
    );
  }

  List<SkillGroup> _assembleSkillGroups(
    List<SkillGroupRow> groups,
    List<SkillRow> skills,
  ) {
    return [
      for (final group in groups)
        skillGroupFromRow(
          group,
          [
            for (final skill in skills)
              if (skill.groupId == group.id) skillFromRow(skill),
          ],
        ),
    ];
  }

  JobDescription _jobFromRow(JobDescriptionRow? row) {
    if (row == null) return const JobDescription();
    return JobDescription(
      id: row.id,
      rawText: row.rawText,
      analyzedAt: row.analyzedAt,
      matchScore: row.matchScore,
      matched: decodeStringList(row.matchedJson),
      missing: decodeStringList(row.missingJson),
    );
  }

  ResumeSettings _settingsFromRow(ResumeSettingsRow row) {
    var order = stringListFromJson(row.sectionOrderJson);
    if (order.isEmpty) order = SectionKeys.defaultOrder;
    return ResumeSettings(
      id: row.id,
      templateId: row.templateId,
      accentColor: row.accentColor,
      fontFamily: row.fontFamily,
      fontSize: row.fontSize,
      margin: row.margin,
      sectionOrder: order,
      sectionVisibility: ResumeSettings.visibilityFromJson(
        row.sectionVisibilityJson,
      ),
      hasSeenOnboarding: row.hasSeenOnboarding,
    );
  }

  @override
  Stream<PersonalInfo> watchPersonalInfo() {
    return _profile.watchPersonalInfo().map(personalInfoFromRow);
  }

  @override
  Future<void> savePersonalInfo(PersonalInfo info) {
    return _profile.upsertPersonalInfo(
      personalInfoToCompanion(info.copyWith(id: 1)),
    );
  }

  @override
  Stream<String> watchSummary() {
    return _profile.watchSummary().map((row) => row.body);
  }

  @override
  Future<void> saveSummary(String body) {
    return _profile.upsertSummary(
      SummaryTableCompanion(id: const Value(1), body: Value(body)),
    );
  }

  @override
  Stream<List<Experience>> watchExperiences() {
    return _profile.watchExperiences().map(
      (rows) => rows.map(experienceFromRow).toList(),
    );
  }

  Future<int> _nextSortOrder(List<int> current) {
    if (current.isEmpty) return Future.value(0);
    return Future.value((current.reduce((a, b) => a > b ? a : b)) + 1);
  }

  @override
  Future<int> addExperience(Experience item) async {
    final next = await _nextSortOrder(
      (await _profile.getExperiences()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertExperience(
      experienceToCompanion(item.copyWith(sortOrder: next)),
    );
  }

  @override
  Future<void> updateExperience(Experience item) {
    return _profile.updateExperience(
      item.id,
      experienceToCompanion(item, withId: true),
    );
  }

  @override
  Future<void> deleteExperience(int id) => _profile.deleteExperience(id);

  @override
  Future<void> reorderExperiences(List<int> ids) =>
      _profile.reorderExperiences(ids);

  @override
  Stream<List<Education>> watchEducations() {
    return _profile.watchEducations().map(
      (rows) => rows.map(educationFromRow).toList(),
    );
  }

  @override
  Future<int> addEducation(Education item) async {
    final next = await _nextSortOrder(
      (await _profile.getEducations()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertEducation(
      educationToCompanion(item.copyWith(sortOrder: next)),
    );
  }

  @override
  Future<void> updateEducation(Education item) {
    return _profile.updateEducation(
      item.id,
      educationToCompanion(item, withId: true),
    );
  }

  @override
  Future<void> deleteEducation(int id) => _profile.deleteEducation(id);

  @override
  Future<void> reorderEducations(List<int> ids) =>
      _profile.reorderEducations(ids);

  @override
  Stream<List<SkillGroup>> watchSkillGroups() {
    late StreamController<List<SkillGroup>> controller;
    final subscriptions = <StreamSubscription<dynamic>>[];

    Future<void> emitGroups() async {
      if (controller.isClosed) return;
      controller.add(
        _assembleSkillGroups(
          await _profile.getSkillGroups(),
          await _profile.getSkills(),
        ),
      );
    }

    controller = StreamController<List<SkillGroup>>.broadcast(
      onListen: () {
        emitGroups();
        subscriptions.addAll([
          _profile.watchSkillGroups().listen((_) => emitGroups()),
          _profile.watchSkills().listen((_) => emitGroups()),
        ]);
      },
      onCancel: () async {
        for (final sub in subscriptions) {
          await sub.cancel();
        }
        subscriptions.clear();
      },
    );
    return controller.stream;
  }

  @override
  Future<int> addSkillGroup(String name) async {
    final next = await _nextSortOrder(
      (await _profile.getSkillGroups()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertSkillGroup(
      SkillGroupsCompanion(name: Value(name), sortOrder: Value(next)),
    );
  }

  @override
  Future<void> renameSkillGroup(int id, String name) {
    return _profile.updateSkillGroup(
      id,
      SkillGroupsCompanion(name: Value(name)),
    );
  }

  @override
  Future<void> deleteSkillGroup(int id) => _profile.deleteSkillGroup(id);

  @override
  Future<int> addSkill(int groupId, String name) async {
    final existing = await _profile.getSkills();
    final inGroup = existing.where((s) => s.groupId == groupId);
    final next = await _nextSortOrder(inGroup.map((e) => e.sortOrder).toList());
    return _profile.insertSkill(
      SkillsCompanion(
        groupId: Value(groupId),
        name: Value(name),
        sortOrder: Value(next),
      ),
    );
  }

  @override
  Future<void> moveSkill(int skillId, int groupId) async {
    final existing = await _profile.getSkills();
    final inGroup = existing.where((s) => s.groupId == groupId && s.id != skillId);
    final next = await _nextSortOrder(inGroup.map((e) => e.sortOrder).toList());
    await _profile.moveSkill(skillId, groupId, next);
  }

  @override
  Future<void> deleteSkill(int id) => _profile.deleteSkill(id);

  @override
  Future<void> reorderSkillGroups(List<int> ids) =>
      _profile.reorderSkillGroups(ids);

  @override
  Future<void> reorderSkills(List<int> ids) => _profile.reorderSkills(ids);

  @override
  Stream<List<Course>> watchCourses() {
    return _profile.watchCourses().map(
      (rows) => rows.map(courseFromRow).toList(),
    );
  }

  @override
  Future<int> addCourse(Course item) async {
    final next = await _nextSortOrder(
      (await _profile.getCourses()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertCourse(courseToCompanion(item.copyWith(sortOrder: next)));
  }

  @override
  Future<void> updateCourse(Course item) {
    return _profile.updateCourse(item.id, courseToCompanion(item, withId: true));
  }

  @override
  Future<void> deleteCourse(int id) => _profile.deleteCourse(id);

  @override
  Future<void> reorderCourses(List<int> ids) => _profile.reorderCourses(ids);

  @override
  Stream<List<Project>> watchProjects() {
    return _profile.watchProjects().map(
      (rows) => rows.map(projectFromRow).toList(),
    );
  }

  @override
  Future<int> addProject(Project item) async {
    final next = await _nextSortOrder(
      (await _profile.getProjects()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertProject(
      projectToCompanion(item.copyWith(sortOrder: next)),
    );
  }

  @override
  Future<void> updateProject(Project item) {
    return _profile.updateProject(
      item.id,
      projectToCompanion(item, withId: true),
    );
  }

  @override
  Future<void> deleteProject(int id) => _profile.deleteProject(id);

  @override
  Future<void> reorderProjects(List<int> ids) => _profile.reorderProjects(ids);

  @override
  Stream<List<Language>> watchLanguages() {
    return _profile.watchLanguages().map(
      (rows) => rows.map(languageFromRow).toList(),
    );
  }

  @override
  Future<int> addLanguage(Language item) async {
    final next = await _nextSortOrder(
      (await _profile.getLanguages()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertLanguage(
      languageToCompanion(item.copyWith(sortOrder: next)),
    );
  }

  @override
  Future<void> updateLanguage(Language item) {
    return _profile.updateLanguage(
      item.id,
      languageToCompanion(item, withId: true),
    );
  }

  @override
  Future<void> deleteLanguage(int id) => _profile.deleteLanguage(id);

  @override
  Future<void> reorderLanguages(List<int> ids) =>
      _profile.reorderLanguages(ids);

  @override
  Stream<List<Award>> watchAwards() {
    return _profile.watchAwards().map((rows) => rows.map(awardFromRow).toList());
  }

  @override
  Future<int> addAward(Award item) async {
    final next = await _nextSortOrder(
      (await _profile.getAwards()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertAward(awardToCompanion(item.copyWith(sortOrder: next)));
  }

  @override
  Future<void> updateAward(Award item) {
    return _profile.updateAward(item.id, awardToCompanion(item, withId: true));
  }

  @override
  Future<void> deleteAward(int id) => _profile.deleteAward(id);

  @override
  Future<void> reorderAwards(List<int> ids) => _profile.reorderAwards(ids);

  @override
  Stream<List<CustomSection>> watchCustomSections() {
    return _profile.watchCustomSections().map(
      (rows) => rows.map(customSectionFromRow).toList(),
    );
  }

  @override
  Future<int> addCustomSection(CustomSection item) async {
    final next = await _nextSortOrder(
      (await _profile.getCustomSections()).map((e) => e.sortOrder).toList(),
    );
    return _profile.insertCustomSection(
      customSectionToCompanion(item.copyWith(sortOrder: next)),
    );
  }

  @override
  Future<void> updateCustomSection(CustomSection item) {
    return _profile.updateCustomSection(
      item.id,
      customSectionToCompanion(item, withId: true),
    );
  }

  @override
  Future<void> deleteCustomSection(int id) => _profile.deleteCustomSection(id);

  @override
  Future<void> reorderCustomSections(List<int> ids) =>
      _profile.reorderCustomSections(ids);

  @override
  Stream<JobDescription> watchJobDescription() {
    return _jobs.watchLatest().map(_jobFromRow);
  }

  @override
  Future<void> saveJobDescription(JobDescription item) {
    return _jobs.upsertLatest(
      JobDescriptionsCompanion(
        rawText: Value(item.rawText),
        analyzedAt: Value(item.analyzedAt),
        matchScore: Value(item.matchScore),
        matchedJson: Value(encodeStringList(item.matched)),
        missingJson: Value(encodeStringList(item.missing)),
      ),
    );
  }

  @override
  Stream<ResumeSettings> watchSettings() {
    return _settings.watch().map(_settingsFromRow);
  }

  @override
  Future<ResumeSettings> getSettings() async {
    return _settingsFromRow(await _settings.get());
  }

  @override
  Future<void> saveSettings(ResumeSettings settings) {
    return _settings.upsert(
      ResumeSettingsTableCompanion(
        id: Value(settings.id),
        templateId: Value(settings.templateId),
        accentColor: Value(settings.accentColor),
        fontFamily: Value(settings.fontFamily),
        fontSize: Value(settings.fontSize),
        margin: Value(settings.margin),
        sectionOrderJson: Value(jsonEncode(settings.sectionOrder)),
        sectionVisibilityJson: Value(jsonEncode(settings.sectionVisibility)),
        hasSeenOnboarding: Value(settings.hasSeenOnboarding),
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> exportJson() async {
    return (await getResume()).toJson();
  }

  @override
  Future<void> importJson(Map<String, dynamic> json) async {
    final data = ResumeData.fromJson(json);
    await _db.transaction(() async {
      await _profile.clearAll();
      await _jobs.clear();

      await savePersonalInfo(data.personal.copyWith(id: 1));
      await saveSummary(data.summary);
      await saveSettings(data.settings.copyWith(id: 1));
      await saveJobDescription(data.jobDescription);

      for (final item in data.experiences) {
        await _profile.insertExperience(
          experienceToCompanion(item.copyWith(id: 0)),
        );
      }
      for (final item in data.educations) {
        await _profile.insertEducation(
          educationToCompanion(item.copyWith(id: 0)),
        );
      }
      for (final group in data.skillGroups) {
        final groupId = await _profile.insertSkillGroup(
          SkillGroupsCompanion(
            name: Value(group.name),
            sortOrder: Value(group.sortOrder),
          ),
        );
        for (final skill in group.skills) {
          await _profile.insertSkill(
            SkillsCompanion(
              groupId: Value(groupId),
              name: Value(skill.name),
              sortOrder: Value(skill.sortOrder),
            ),
          );
        }
      }
      for (final item in data.courses) {
        await _profile.insertCourse(courseToCompanion(item.copyWith(id: 0)));
      }
      for (final item in data.projects) {
        await _profile.insertProject(projectToCompanion(item.copyWith(id: 0)));
      }
      for (final item in data.languages) {
        await _profile.insertLanguage(languageToCompanion(item.copyWith(id: 0)));
      }
      for (final item in data.awards) {
        await _profile.insertAward(awardToCompanion(item.copyWith(id: 0)));
      }
      for (final item in data.customSections) {
        await _profile.insertCustomSection(
          customSectionToCompanion(item.copyWith(id: 0)),
        );
      }
    });
  }
}
