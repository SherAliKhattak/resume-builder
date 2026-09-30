import '../../../../core/utils/json_list.dart';

class PersonalInfo {
  const PersonalInfo({
    this.id = 1,
    this.fullName = '',
    this.title = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.linkedin = '',
    this.github = '',
    this.portfolio = '',
  });

  final int id;
  final String fullName;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String linkedin;
  final String github;
  final String portfolio;

  bool get isComplete =>
      fullName.trim().isNotEmpty && email.trim().isNotEmpty;

  PersonalInfo copyWith({
    int? id,
    String? fullName,
    String? title,
    String? email,
    String? phone,
    String? location,
    String? linkedin,
    String? github,
    String? portfolio,
  }) {
    return PersonalInfo(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'title': title,
    'email': email,
    'phone': phone,
    'location': location,
    'linkedin': linkedin,
    'github': github,
    'portfolio': portfolio,
  };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      id: readInt(json, 'id', 1),
      fullName: readString(json, 'fullName'),
      title: readString(json, 'title'),
      email: readString(json, 'email'),
      phone: readString(json, 'phone'),
      location: readString(json, 'location'),
      linkedin: readString(json, 'linkedin'),
      github: readString(json, 'github'),
      portfolio: readString(json, 'portfolio'),
    );
  }
}

class Experience {
  const Experience({
    this.id = 0,
    this.company = '',
    this.role = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrent = false,
    this.bullets = const [],
    this.sortOrder = 0,
  });

  final int id;
  final String company;
  final String role;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final List<String> bullets;
  final int sortOrder;

  Experience copyWith({
    int? id,
    String? company,
    String? role,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    List<String>? bullets,
    int? sortOrder,
  }) {
    return Experience(
      id: id ?? this.id,
      company: company ?? this.company,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      bullets: bullets ?? this.bullets,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'company': company,
    'role': role,
    'startDate': startDate,
    'endDate': endDate,
    'isCurrent': isCurrent,
    'bullets': bullets,
    'sortOrder': sortOrder,
  };

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: readInt(json, 'id'),
      company: readString(json, 'company'),
      role: readString(json, 'role'),
      startDate: readString(json, 'startDate'),
      endDate: readString(json, 'endDate'),
      isCurrent: readBool(json, 'isCurrent'),
      bullets: stringListFromJson(json['bullets']),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class Education {
  const Education({
    this.id = 0,
    this.school = '',
    this.degree = '',
    this.field = '',
    this.startDate = '',
    this.endDate = '',
    this.details = '',
    this.sortOrder = 0,
  });

  final int id;
  final String school;
  final String degree;
  final String field;
  final String startDate;
  final String endDate;
  final String details;
  final int sortOrder;

  Education copyWith({
    int? id,
    String? school,
    String? degree,
    String? field,
    String? startDate,
    String? endDate,
    String? details,
    int? sortOrder,
  }) {
    return Education(
      id: id ?? this.id,
      school: school ?? this.school,
      degree: degree ?? this.degree,
      field: field ?? this.field,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      details: details ?? this.details,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'school': school,
    'degree': degree,
    'field': field,
    'startDate': startDate,
    'endDate': endDate,
    'details': details,
    'sortOrder': sortOrder,
  };

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: readInt(json, 'id'),
      school: readString(json, 'school'),
      degree: readString(json, 'degree'),
      field: readString(json, 'field'),
      startDate: readString(json, 'startDate'),
      endDate: readString(json, 'endDate'),
      details: readString(json, 'details'),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class Skill {
  const Skill({
    this.id = 0,
    this.groupId = 0,
    this.name = '',
    this.sortOrder = 0,
  });

  final int id;
  final int groupId;
  final String name;
  final int sortOrder;

  Skill copyWith({int? id, int? groupId, String? name, int? sortOrder}) {
    return Skill(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'groupId': groupId,
    'name': name,
    'sortOrder': sortOrder,
  };

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: readInt(json, 'id'),
      groupId: readInt(json, 'groupId'),
      name: readString(json, 'name'),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class SkillGroup {
  const SkillGroup({
    this.id = 0,
    this.name = '',
    this.sortOrder = 0,
    this.skills = const [],
  });

  final int id;
  final String name;
  final int sortOrder;
  final List<Skill> skills;

  SkillGroup copyWith({
    int? id,
    String? name,
    int? sortOrder,
    List<Skill>? skills,
  }) {
    return SkillGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sortOrder': sortOrder,
    'skills': skills.map((s) => s.toJson()).toList(),
  };

  factory SkillGroup.fromJson(Map<String, dynamic> json) {
    return SkillGroup(
      id: readInt(json, 'id'),
      name: readString(json, 'name'),
      sortOrder: readInt(json, 'sortOrder'),
      skills: [
        for (final item in (json['skills'] as List? ?? const []))
          if (item is Map<String, dynamic>) Skill.fromJson(item),
      ],
    );
  }
}

class Course {
  const Course({
    this.id = 0,
    this.name = '',
    this.issuer = '',
    this.date = '',
    this.url = '',
    this.sortOrder = 0,
  });

  final int id;
  final String name;
  final String issuer;
  final String date;
  final String url;
  final int sortOrder;

  Course copyWith({
    int? id,
    String? name,
    String? issuer,
    String? date,
    String? url,
    int? sortOrder,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      url: url ?? this.url,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'issuer': issuer,
    'date': date,
    'url': url,
    'sortOrder': sortOrder,
  };

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: readInt(json, 'id'),
      name: readString(json, 'name'),
      issuer: readString(json, 'issuer'),
      date: readString(json, 'date'),
      url: readString(json, 'url'),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class Project {
  const Project({
    this.id = 0,
    this.name = '',
    this.link = '',
    this.description = '',
    this.techStack = '',
    this.bullets = const [],
    this.sortOrder = 0,
  });

  final int id;
  final String name;
  final String link;
  final String description;
  final String techStack;
  final List<String> bullets;
  final int sortOrder;

  Project copyWith({
    int? id,
    String? name,
    String? link,
    String? description,
    String? techStack,
    List<String>? bullets,
    int? sortOrder,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      description: description ?? this.description,
      techStack: techStack ?? this.techStack,
      bullets: bullets ?? this.bullets,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'link': link,
    'description': description,
    'techStack': techStack,
    'bullets': bullets,
    'sortOrder': sortOrder,
  };

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: readInt(json, 'id'),
      name: readString(json, 'name'),
      link: readString(json, 'link'),
      description: readString(json, 'description'),
      techStack: readString(json, 'techStack'),
      bullets: stringListFromJson(json['bullets']),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class Language {
  const Language({
    this.id = 0,
    this.name = '',
    this.proficiency = '',
    this.sortOrder = 0,
  });

  final int id;
  final String name;
  final String proficiency;
  final int sortOrder;

  Language copyWith({
    int? id,
    String? name,
    String? proficiency,
    int? sortOrder,
  }) {
    return Language(
      id: id ?? this.id,
      name: name ?? this.name,
      proficiency: proficiency ?? this.proficiency,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'proficiency': proficiency,
    'sortOrder': sortOrder,
  };

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: readInt(json, 'id'),
      name: readString(json, 'name'),
      proficiency: readString(json, 'proficiency'),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class Award {
  const Award({
    this.id = 0,
    this.title = '',
    this.issuer = '',
    this.date = '',
    this.description = '',
    this.sortOrder = 0,
  });

  final int id;
  final String title;
  final String issuer;
  final String date;
  final String description;
  final int sortOrder;

  Award copyWith({
    int? id,
    String? title,
    String? issuer,
    String? date,
    String? description,
    int? sortOrder,
  }) {
    return Award(
      id: id ?? this.id,
      title: title ?? this.title,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'issuer': issuer,
    'date': date,
    'description': description,
    'sortOrder': sortOrder,
  };

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      id: readInt(json, 'id'),
      title: readString(json, 'title'),
      issuer: readString(json, 'issuer'),
      date: readString(json, 'date'),
      description: readString(json, 'description'),
      sortOrder: readInt(json, 'sortOrder'),
    );
  }
}

class CustomSection {
  const CustomSection({
    this.id = 0,
    this.title = '',
    this.body = '',
    this.sortOrder = 0,
    this.isVisible = true,
  });

  final int id;
  final String title;
  final String body;
  final int sortOrder;
  final bool isVisible;

  CustomSection copyWith({
    int? id,
    String? title,
    String? body,
    int? sortOrder,
    bool? isVisible,
  }) {
    return CustomSection(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      sortOrder: sortOrder ?? this.sortOrder,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'sortOrder': sortOrder,
    'isVisible': isVisible,
  };

  factory CustomSection.fromJson(Map<String, dynamic> json) {
    return CustomSection(
      id: readInt(json, 'id'),
      title: readString(json, 'title'),
      body: readString(json, 'body'),
      sortOrder: readInt(json, 'sortOrder'),
      isVisible: readBool(json, 'isVisible', true),
    );
  }
}
