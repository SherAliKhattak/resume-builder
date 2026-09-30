import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import '../../features/profile/domain/models/profile_models.dart';
import '../../features/profile/domain/models/resume_data.dart';
import '../../features/profile/domain/repositories/resume_repository.dart';
import 'resume_file_reader.dart';
import 'resume_text_parser.dart';

class ResumeImportResult {
  const ResumeImportResult({
    this.cancelled = false,
    this.filled = const [],
  });

  final bool cancelled;
  final List<String> filled;

  String get message {
    if (cancelled) return '';
    if (filled.isEmpty) {
      return 'Nothing new to add. You can fill any remaining fields by hand.';
    }
    return 'Added ${filled.join(', ')}. Fill anything still missing by hand.';
  }
}

class ResumeImportService {
  ResumeImportService(this._repository);

  final ResumeRepository _repository;

  Future<ResumeImportResult> importFromPicker() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const [
        'pdf',
        'docx',
        'txt',
        'rtf',
        'md',
        'html',
        'htm',
        'json',
      ],
    );
    if (files.isEmpty) return const ResumeImportResult(cancelled: true);
    final file = files.first;
    return importBytes(
      bytes: Uint8List.fromList(await file.readAsBytes()),
      filename: file.name,
    );
  }

  Future<ResumeImportResult> importBytes({
    required Uint8List bytes,
    required String filename,
  }) async {
    final parsed = _parse(bytes, filename);
    return merge(parsed);
  }

  ResumeData _parse(Uint8List bytes, String filename) {
    if (filename.toLowerCase().endsWith('.json')) {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is Map) {
        return ResumeData.fromJson(Map<String, dynamic>.from(decoded));
      }
      throw const FormatException('That JSON file is not a resume.');
    }
    final text = ResumeFileReader.read(bytes, filename);
    return ResumeTextParser.parse(text);
  }

  Future<ResumeImportResult> merge(ResumeData incoming) async {
    final current = await _repository.getResume();
    final filled = <String>[];

    final personal = _mergePersonal(current.personal, incoming.personal);
    final personalFilled = _personalLabels(current.personal, personal);
    if (personalFilled.isNotEmpty) {
      await _repository.savePersonalInfo(personal);
      filled.addAll(personalFilled);
    }

    if (current.summary.trim().isEmpty && incoming.summary.trim().isNotEmpty) {
      await _repository.saveSummary(incoming.summary.trim());
      filled.add('summary');
    }

    var addedJobs = 0;
    for (final item in incoming.experiences) {
      if (_hasJob(current.experiences, item)) continue;
      await _repository.addExperience(item.copyWith(id: 0));
      addedJobs++;
    }
    if (addedJobs > 0) filled.add(addedJobs == 1 ? '1 job' : '$addedJobs jobs');

    var addedSchools = 0;
    for (final item in incoming.educations) {
      if (_hasSchool(current.educations, item)) continue;
      await _repository.addEducation(item.copyWith(id: 0));
      addedSchools++;
    }
    if (addedSchools > 0) {
      filled.add(addedSchools == 1 ? '1 school' : '$addedSchools schools');
    }

    final skillNames = [
      for (final group in incoming.skillGroups)
        for (final skill in group.skills)
          if (skill.name.trim().isNotEmpty) skill.name.trim(),
    ];
    final existingSkills = {
      for (final group in current.skillGroups)
        for (final skill in group.skills) skill.name.trim().toLowerCase(),
    };
    final newSkills = [
      for (final name in skillNames)
        if (!existingSkills.contains(name.toLowerCase())) name,
    ];
    if (newSkills.isNotEmpty) {
      var groupId = current.skillGroups.isEmpty
          ? await _repository.addSkillGroup('Skills')
          : current.skillGroups.first.id;
      for (final name in newSkills.take(24)) {
        await _repository.addSkill(groupId, name);
      }
      filled.add(newSkills.length == 1 ? '1 skill' : '${newSkills.length} skills');
    }

    var addedProjects = 0;
    for (final item in incoming.projects) {
      if (_hasNamed(current.projects.map((e) => e.name), item.name)) continue;
      await _repository.addProject(item.copyWith(id: 0));
      addedProjects++;
    }
    if (addedProjects > 0) {
      filled.add(addedProjects == 1 ? '1 project' : '$addedProjects projects');
    }

    var addedLanguages = 0;
    for (final item in incoming.languages) {
      if (_hasNamed(current.languages.map((e) => e.name), item.name)) continue;
      await _repository.addLanguage(item.copyWith(id: 0));
      addedLanguages++;
    }
    if (addedLanguages > 0) {
      filled.add(
        addedLanguages == 1 ? '1 language' : '$addedLanguages languages',
      );
    }

    var addedAwards = 0;
    for (final item in incoming.awards) {
      if (_hasNamed(current.awards.map((e) => e.title), item.title)) continue;
      await _repository.addAward(item.copyWith(id: 0));
      addedAwards++;
    }
    if (addedAwards > 0) {
      filled.add(addedAwards == 1 ? '1 award' : '$addedAwards awards');
    }

    var addedCourses = 0;
    for (final item in incoming.courses) {
      if (_hasNamed(current.courses.map((e) => e.name), item.name)) continue;
      await _repository.addCourse(item.copyWith(id: 0));
      addedCourses++;
    }
    if (addedCourses > 0) {
      filled.add(addedCourses == 1 ? '1 course' : '$addedCourses courses');
    }

    return ResumeImportResult(filled: filled);
  }

  PersonalInfo _mergePersonal(PersonalInfo current, PersonalInfo incoming) {
    String take(String now, String next) => now.trim().isEmpty ? next.trim() : now;
    return current.copyWith(
      fullName: take(current.fullName, incoming.fullName),
      title: take(current.title, incoming.title),
      email: take(current.email, incoming.email),
      phone: take(current.phone, incoming.phone),
      location: take(current.location, incoming.location),
      linkedin: take(current.linkedin, incoming.linkedin),
      github: take(current.github, incoming.github),
      portfolio: take(current.portfolio, incoming.portfolio),
    );
  }

  List<String> _personalLabels(PersonalInfo before, PersonalInfo after) {
    final labels = <String>[];
    void add(String label, String left, String right) {
      if (left.trim().isEmpty && right.trim().isNotEmpty) labels.add(label);
    }

    add('name', before.fullName, after.fullName);
    add('title', before.title, after.title);
    add('email', before.email, after.email);
    add('phone', before.phone, after.phone);
    add('location', before.location, after.location);
    add('LinkedIn', before.linkedin, after.linkedin);
    add('GitHub', before.github, after.github);
    add('portfolio', before.portfolio, after.portfolio);
    return labels;
  }

  bool _hasJob(List<Experience> current, Experience incoming) {
    final role = incoming.role.trim().toLowerCase();
    final company = incoming.company.trim().toLowerCase();
    return current.any(
      (item) =>
          item.role.trim().toLowerCase() == role &&
          item.company.trim().toLowerCase() == company &&
          role.isNotEmpty,
    );
  }

  bool _hasSchool(List<Education> current, Education incoming) {
    final school = incoming.school.trim().toLowerCase();
    return school.isNotEmpty &&
        current.any((item) => item.school.trim().toLowerCase() == school);
  }

  bool _hasNamed(Iterable<String> current, String incoming) {
    final name = incoming.trim().toLowerCase();
    return name.isNotEmpty &&
        current.any((item) => item.trim().toLowerCase() == name);
  }
}
