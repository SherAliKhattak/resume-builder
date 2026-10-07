import '../models/profile_models.dart';
import '../models/resume_data.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../../job_description/domain/models/job_description.dart';

abstract class ResumeRepository {
  Stream<ResumeData> watchResume();
  Future<ResumeData> getResume();

  Stream<PersonalInfo> watchPersonalInfo();
  Future<void> savePersonalInfo(PersonalInfo info);

  Stream<String> watchSummary();
  Future<void> saveSummary(String body);

  Stream<List<Experience>> watchExperiences();
  Future<int> addExperience(Experience item);
  Future<void> updateExperience(Experience item);
  Future<void> deleteExperience(int id);
  Future<void> reorderExperiences(List<int> ids);

  Stream<List<Education>> watchEducations();
  Future<int> addEducation(Education item);
  Future<void> updateEducation(Education item);
  Future<void> deleteEducation(int id);
  Future<void> reorderEducations(List<int> ids);

  Stream<List<SkillGroup>> watchSkillGroups();
  Future<int> addSkillGroup(String name);
  Future<void> renameSkillGroup(int id, String name);
  Future<void> deleteSkillGroup(int id);
  Future<int> addSkill(int groupId, String name);
  Future<void> moveSkill(int skillId, int groupId);
  Future<void> deleteSkill(int id);
  Future<void> reorderSkillGroups(List<int> ids);
  Future<void> reorderSkills(List<int> ids);

  Stream<List<Course>> watchCourses();
  Future<int> addCourse(Course item);
  Future<void> updateCourse(Course item);
  Future<void> deleteCourse(int id);
  Future<void> reorderCourses(List<int> ids);

  Stream<List<Project>> watchProjects();
  Future<int> addProject(Project item);
  Future<void> updateProject(Project item);
  Future<void> deleteProject(int id);
  Future<void> reorderProjects(List<int> ids);

  Stream<List<Language>> watchLanguages();
  Future<int> addLanguage(Language item);
  Future<void> updateLanguage(Language item);
  Future<void> deleteLanguage(int id);
  Future<void> reorderLanguages(List<int> ids);

  Stream<List<Award>> watchAwards();
  Future<int> addAward(Award item);
  Future<void> updateAward(Award item);
  Future<void> deleteAward(int id);
  Future<void> reorderAwards(List<int> ids);

  Stream<List<CustomSection>> watchCustomSections();
  Future<int> addCustomSection(CustomSection item);
  Future<void> updateCustomSection(CustomSection item);
  Future<void> deleteCustomSection(int id);
  Future<void> reorderCustomSections(List<int> ids);

  Stream<JobDescription> watchJobDescription();
  Future<void> saveJobDescription(JobDescription item);

  Stream<ResumeSettings> watchSettings();
  Future<ResumeSettings> getSettings();
  Future<void> saveSettings(ResumeSettings settings);

  Future<Map<String, dynamic>> exportJson();
  Future<void> importJson(Map<String, dynamic> json);
}
