import '../../profile/domain/models/resume_data.dart';

/// Helvetica/Times cannot draw most Unicode. Unmapped glyphs throw while
/// building the PDF, which made preview look like it was broken.
String pdfSafe(String input) {
  if (input.isEmpty) return input;
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    switch (rune) {
      case 0x9:
      case 0xA:
      case 0xD:
        buffer.writeCharCode(rune);
      case 0xA0:
      case 0x202F:
      case 0x2007:
        buffer.write(' ');
      case 0x2018:
      case 0x2019:
      case 0x201A:
      case 0x2032:
        buffer.write("'");
      case 0x201C:
      case 0x201D:
      case 0x201E:
      case 0x2033:
        buffer.write('"');
      case 0x2013:
      case 0x2014:
      case 0x2212:
        buffer.write('-');
      case 0x2022:
      case 0x2023:
      case 0x25CF:
      case 0x25E6:
        buffer.write('-');
      case 0x2026:
        buffer.write('...');
      default:
        if (rune >= 0x20 && rune <= 0x7E) {
          buffer.writeCharCode(rune);
        } else if (rune >= 0xA1 && rune <= 0xFF) {
          buffer.writeCharCode(rune);
        }
    }
  }
  return buffer.toString();
}

ResumeData pdfSafeResume(ResumeData data) {
  return data.copyWith(
    personal: data.personal.copyWith(
      fullName: pdfSafe(data.personal.fullName),
      title: pdfSafe(data.personal.title),
      email: pdfSafe(data.personal.email),
      phone: pdfSafe(data.personal.phone),
      location: pdfSafe(data.personal.location),
      linkedin: pdfSafe(data.personal.linkedin),
      github: pdfSafe(data.personal.github),
      portfolio: pdfSafe(data.personal.portfolio),
    ),
    summary: pdfSafe(data.summary),
    experiences: [
      for (final item in data.experiences)
        item.copyWith(
          company: pdfSafe(item.company),
          role: pdfSafe(item.role),
          startDate: pdfSafe(item.startDate),
          endDate: pdfSafe(item.endDate),
          bullets: [for (final bullet in item.bullets) pdfSafe(bullet)],
        ),
    ],
    educations: [
      for (final item in data.educations)
        item.copyWith(
          school: pdfSafe(item.school),
          degree: pdfSafe(item.degree),
          field: pdfSafe(item.field),
          startDate: pdfSafe(item.startDate),
          endDate: pdfSafe(item.endDate),
          details: pdfSafe(item.details),
        ),
    ],
    skillGroups: [
      for (final group in data.skillGroups)
        group.copyWith(
          name: pdfSafe(group.name),
          skills: [
            for (final skill in group.skills)
              skill.copyWith(name: pdfSafe(skill.name)),
          ],
        ),
    ],
    courses: [
      for (final item in data.courses)
        item.copyWith(
          name: pdfSafe(item.name),
          issuer: pdfSafe(item.issuer),
          date: pdfSafe(item.date),
          url: pdfSafe(item.url),
        ),
    ],
    projects: [
      for (final item in data.projects)
        item.copyWith(
          name: pdfSafe(item.name),
          description: pdfSafe(item.description),
          link: pdfSafe(item.link),
          techStack: pdfSafe(item.techStack),
          bullets: [for (final bullet in item.bullets) pdfSafe(bullet)],
        ),
    ],
    languages: [
      for (final item in data.languages)
        item.copyWith(
          name: pdfSafe(item.name),
          proficiency: pdfSafe(item.proficiency),
        ),
    ],
    awards: [
      for (final item in data.awards)
        item.copyWith(
          title: pdfSafe(item.title),
          issuer: pdfSafe(item.issuer),
          date: pdfSafe(item.date),
          description: pdfSafe(item.description),
        ),
    ],
    customSections: [
      for (final item in data.customSections)
        item.copyWith(
          title: pdfSafe(item.title),
          body: pdfSafe(item.body),
        ),
    ],
  );
}
