import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/json_list.dart';
import '../../domain/models/profile_models.dart';

PersonalInfo personalInfoFromRow(PersonalInfoRow row) {
  return PersonalInfo(
    id: row.id,
    fullName: row.fullName,
    title: row.title,
    email: row.email,
    phone: row.phone,
    location: row.location,
    linkedin: row.linkedin,
    github: row.github,
    portfolio: row.portfolio,
  );
}

PersonalInfoTableCompanion personalInfoToCompanion(PersonalInfo info) {
  return PersonalInfoTableCompanion(
    id: Value(info.id),
    fullName: Value(info.fullName),
    title: Value(info.title),
    email: Value(info.email),
    phone: Value(info.phone),
    location: Value(info.location),
    linkedin: Value(info.linkedin),
    github: Value(info.github),
    portfolio: Value(info.portfolio),
  );
}

Experience experienceFromRow(ExperienceRow row) {
  return Experience(
    id: row.id,
    company: row.company,
    role: row.role,
    startDate: row.startDate,
    endDate: row.endDate,
    isCurrent: row.isCurrent,
    bullets: decodeStringList(row.bulletsJson),
    sortOrder: row.sortOrder,
  );
}

ExperiencesCompanion experienceToCompanion(Experience item, {bool withId = false}) {
  return ExperiencesCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    company: Value(item.company),
    role: Value(item.role),
    startDate: Value(item.startDate),
    endDate: Value(item.endDate),
    isCurrent: Value(item.isCurrent),
    bulletsJson: Value(encodeStringList(item.bullets)),
    sortOrder: Value(item.sortOrder),
  );
}

Education educationFromRow(EducationRow row) {
  return Education(
    id: row.id,
    school: row.school,
    degree: row.degree,
    field: row.field,
    startDate: row.startDate,
    endDate: row.endDate,
    details: row.details,
    sortOrder: row.sortOrder,
  );
}

EducationsCompanion educationToCompanion(Education item, {bool withId = false}) {
  return EducationsCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    school: Value(item.school),
    degree: Value(item.degree),
    field: Value(item.field),
    startDate: Value(item.startDate),
    endDate: Value(item.endDate),
    details: Value(item.details),
    sortOrder: Value(item.sortOrder),
  );
}

Skill skillFromRow(SkillRow row) {
  return Skill(
    id: row.id,
    groupId: row.groupId,
    name: row.name,
    sortOrder: row.sortOrder,
  );
}

SkillGroup skillGroupFromRow(SkillGroupRow row, List<Skill> skills) {
  return SkillGroup(
    id: row.id,
    name: row.name,
    sortOrder: row.sortOrder,
    skills: skills,
  );
}

Course courseFromRow(CourseRow row) {
  return Course(
    id: row.id,
    name: row.name,
    issuer: row.issuer,
    date: row.date,
    url: row.url,
    sortOrder: row.sortOrder,
  );
}

CoursesCompanion courseToCompanion(Course item, {bool withId = false}) {
  return CoursesCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    name: Value(item.name),
    issuer: Value(item.issuer),
    date: Value(item.date),
    url: Value(item.url),
    sortOrder: Value(item.sortOrder),
  );
}

Project projectFromRow(ProjectRow row) {
  return Project(
    id: row.id,
    name: row.name,
    link: row.link,
    description: row.description,
    techStack: row.techStack,
    bullets: decodeStringList(row.bulletsJson),
    sortOrder: row.sortOrder,
  );
}

ProjectsCompanion projectToCompanion(Project item, {bool withId = false}) {
  return ProjectsCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    name: Value(item.name),
    link: Value(item.link),
    description: Value(item.description),
    techStack: Value(item.techStack),
    bulletsJson: Value(encodeStringList(item.bullets)),
    sortOrder: Value(item.sortOrder),
  );
}

Language languageFromRow(LanguageRow row) {
  return Language(
    id: row.id,
    name: row.name,
    proficiency: row.proficiency,
    sortOrder: row.sortOrder,
  );
}

LanguagesCompanion languageToCompanion(Language item, {bool withId = false}) {
  return LanguagesCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    name: Value(item.name),
    proficiency: Value(item.proficiency),
    sortOrder: Value(item.sortOrder),
  );
}

Award awardFromRow(AwardRow row) {
  return Award(
    id: row.id,
    title: row.title,
    issuer: row.issuer,
    date: row.date,
    description: row.description,
    sortOrder: row.sortOrder,
  );
}

AwardsCompanion awardToCompanion(Award item, {bool withId = false}) {
  return AwardsCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    title: Value(item.title),
    issuer: Value(item.issuer),
    date: Value(item.date),
    description: Value(item.description),
    sortOrder: Value(item.sortOrder),
  );
}

CustomSection customSectionFromRow(CustomSectionRow row) {
  return CustomSection(
    id: row.id,
    title: row.title,
    body: row.body,
    sortOrder: row.sortOrder,
    isVisible: row.isVisible,
  );
}

CustomSectionsCompanion customSectionToCompanion(
  CustomSection item, {
  bool withId = false,
}) {
  return CustomSectionsCompanion(
    id: withId ? Value(item.id) : const Value.absent(),
    title: Value(item.title),
    body: Value(item.body),
    sortOrder: Value(item.sortOrder),
    isVisible: Value(item.isVisible),
  );
}
