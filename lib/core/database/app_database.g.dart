// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PersonalInfoTableTable extends PersonalInfoTable
    with TableInfo<$PersonalInfoTableTable, PersonalInfoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _linkedinMeta = const VerificationMeta(
    'linkedin',
  );
  @override
  late final GeneratedColumn<String> linkedin = GeneratedColumn<String>(
    'linkedin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _githubMeta = const VerificationMeta('github');
  @override
  late final GeneratedColumn<String> github = GeneratedColumn<String>(
    'github',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _portfolioMeta = const VerificationMeta(
    'portfolio',
  );
  @override
  late final GeneratedColumn<String> portfolio = GeneratedColumn<String>(
    'portfolio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    title,
    email,
    phone,
    location,
    linkedin,
    github,
    portfolio,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalInfoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('linkedin')) {
      context.handle(
        _linkedinMeta,
        linkedin.isAcceptableOrUnknown(data['linkedin']!, _linkedinMeta),
      );
    }
    if (data.containsKey('github')) {
      context.handle(
        _githubMeta,
        github.isAcceptableOrUnknown(data['github']!, _githubMeta),
      );
    }
    if (data.containsKey('portfolio')) {
      context.handle(
        _portfolioMeta,
        portfolio.isAcceptableOrUnknown(data['portfolio']!, _portfolioMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalInfoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalInfoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      linkedin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linkedin'],
      )!,
      github: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}github'],
      )!,
      portfolio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio'],
      )!,
    );
  }

  @override
  $PersonalInfoTableTable createAlias(String alias) {
    return $PersonalInfoTableTable(attachedDatabase, alias);
  }
}

class PersonalInfoRow extends DataClass implements Insertable<PersonalInfoRow> {
  final int id;
  final String fullName;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String linkedin;
  final String github;
  final String portfolio;
  const PersonalInfoRow({
    required this.id,
    required this.fullName,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.linkedin,
    required this.github,
    required this.portfolio,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['title'] = Variable<String>(title);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['location'] = Variable<String>(location);
    map['linkedin'] = Variable<String>(linkedin);
    map['github'] = Variable<String>(github);
    map['portfolio'] = Variable<String>(portfolio);
    return map;
  }

  PersonalInfoTableCompanion toCompanion(bool nullToAbsent) {
    return PersonalInfoTableCompanion(
      id: Value(id),
      fullName: Value(fullName),
      title: Value(title),
      email: Value(email),
      phone: Value(phone),
      location: Value(location),
      linkedin: Value(linkedin),
      github: Value(github),
      portfolio: Value(portfolio),
    );
  }

  factory PersonalInfoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalInfoRow(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      title: serializer.fromJson<String>(json['title']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      location: serializer.fromJson<String>(json['location']),
      linkedin: serializer.fromJson<String>(json['linkedin']),
      github: serializer.fromJson<String>(json['github']),
      portfolio: serializer.fromJson<String>(json['portfolio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'title': serializer.toJson<String>(title),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'location': serializer.toJson<String>(location),
      'linkedin': serializer.toJson<String>(linkedin),
      'github': serializer.toJson<String>(github),
      'portfolio': serializer.toJson<String>(portfolio),
    };
  }

  PersonalInfoRow copyWith({
    int? id,
    String? fullName,
    String? title,
    String? email,
    String? phone,
    String? location,
    String? linkedin,
    String? github,
    String? portfolio,
  }) => PersonalInfoRow(
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
  PersonalInfoRow copyWithCompanion(PersonalInfoTableCompanion data) {
    return PersonalInfoRow(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      title: data.title.present ? data.title.value : this.title,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      location: data.location.present ? data.location.value : this.location,
      linkedin: data.linkedin.present ? data.linkedin.value : this.linkedin,
      github: data.github.present ? data.github.value : this.github,
      portfolio: data.portfolio.present ? data.portfolio.value : this.portfolio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalInfoRow(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('title: $title, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('location: $location, ')
          ..write('linkedin: $linkedin, ')
          ..write('github: $github, ')
          ..write('portfolio: $portfolio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    title,
    email,
    phone,
    location,
    linkedin,
    github,
    portfolio,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalInfoRow &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.title == this.title &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.location == this.location &&
          other.linkedin == this.linkedin &&
          other.github == this.github &&
          other.portfolio == this.portfolio);
}

class PersonalInfoTableCompanion extends UpdateCompanion<PersonalInfoRow> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<String> title;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> location;
  final Value<String> linkedin;
  final Value<String> github;
  final Value<String> portfolio;
  const PersonalInfoTableCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.title = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.location = const Value.absent(),
    this.linkedin = const Value.absent(),
    this.github = const Value.absent(),
    this.portfolio = const Value.absent(),
  });
  PersonalInfoTableCompanion.insert({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.title = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.location = const Value.absent(),
    this.linkedin = const Value.absent(),
    this.github = const Value.absent(),
    this.portfolio = const Value.absent(),
  });
  static Insertable<PersonalInfoRow> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? title,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? location,
    Expression<String>? linkedin,
    Expression<String>? github,
    Expression<String>? portfolio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (title != null) 'title': title,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (location != null) 'location': location,
      if (linkedin != null) 'linkedin': linkedin,
      if (github != null) 'github': github,
      if (portfolio != null) 'portfolio': portfolio,
    });
  }

  PersonalInfoTableCompanion copyWith({
    Value<int>? id,
    Value<String>? fullName,
    Value<String>? title,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? location,
    Value<String>? linkedin,
    Value<String>? github,
    Value<String>? portfolio,
  }) {
    return PersonalInfoTableCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (linkedin.present) {
      map['linkedin'] = Variable<String>(linkedin.value);
    }
    if (github.present) {
      map['github'] = Variable<String>(github.value);
    }
    if (portfolio.present) {
      map['portfolio'] = Variable<String>(portfolio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('title: $title, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('location: $location, ')
          ..write('linkedin: $linkedin, ')
          ..write('github: $github, ')
          ..write('portfolio: $portfolio')
          ..write(')'))
        .toString();
  }
}

class $SummaryTableTable extends SummaryTable
    with TableInfo<$SummaryTableTable, SummaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SummaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, body];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'summary';
  @override
  VerificationContext validateIntegrity(
    Insertable<SummaryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SummaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SummaryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  $SummaryTableTable createAlias(String alias) {
    return $SummaryTableTable(attachedDatabase, alias);
  }
}

class SummaryRow extends DataClass implements Insertable<SummaryRow> {
  final int id;
  final String body;
  const SummaryRow({required this.id, required this.body});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['body'] = Variable<String>(body);
    return map;
  }

  SummaryTableCompanion toCompanion(bool nullToAbsent) {
    return SummaryTableCompanion(id: Value(id), body: Value(body));
  }

  factory SummaryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SummaryRow(
      id: serializer.fromJson<int>(json['id']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'body': serializer.toJson<String>(body),
    };
  }

  SummaryRow copyWith({int? id, String? body}) =>
      SummaryRow(id: id ?? this.id, body: body ?? this.body);
  SummaryRow copyWithCompanion(SummaryTableCompanion data) {
    return SummaryRow(
      id: data.id.present ? data.id.value : this.id,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SummaryRow(')
          ..write('id: $id, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SummaryRow && other.id == this.id && other.body == this.body);
}

class SummaryTableCompanion extends UpdateCompanion<SummaryRow> {
  final Value<int> id;
  final Value<String> body;
  const SummaryTableCompanion({
    this.id = const Value.absent(),
    this.body = const Value.absent(),
  });
  SummaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.body = const Value.absent(),
  });
  static Insertable<SummaryRow> custom({
    Expression<int>? id,
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (body != null) 'body': body,
    });
  }

  SummaryTableCompanion copyWith({Value<int>? id, Value<String>? body}) {
    return SummaryTableCompanion(id: id ?? this.id, body: body ?? this.body);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SummaryTableCompanion(')
          ..write('id: $id, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class $ExperiencesTable extends Experiences
    with TableInfo<$ExperiencesTable, ExperienceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperiencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _companyMeta = const VerificationMeta(
    'company',
  );
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
    'company',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bulletsJsonMeta = const VerificationMeta(
    'bulletsJson',
  );
  @override
  late final GeneratedColumn<String> bulletsJson = GeneratedColumn<String>(
    'bullets_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    company,
    role,
    startDate,
    endDate,
    isCurrent,
    bulletsJson,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experiences';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExperienceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company')) {
      context.handle(
        _companyMeta,
        company.isAcceptableOrUnknown(data['company']!, _companyMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    }
    if (data.containsKey('bullets_json')) {
      context.handle(
        _bulletsJsonMeta,
        bulletsJson.isAcceptableOrUnknown(
          data['bullets_json']!,
          _bulletsJsonMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExperienceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExperienceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      company: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      )!,
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current'],
      )!,
      bulletsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bullets_json'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ExperiencesTable createAlias(String alias) {
    return $ExperiencesTable(attachedDatabase, alias);
  }
}

class ExperienceRow extends DataClass implements Insertable<ExperienceRow> {
  final int id;
  final String company;
  final String role;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String bulletsJson;
  final int sortOrder;
  const ExperienceRow({
    required this.id,
    required this.company,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.bulletsJson,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['company'] = Variable<String>(company);
    map['role'] = Variable<String>(role);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['is_current'] = Variable<bool>(isCurrent);
    map['bullets_json'] = Variable<String>(bulletsJson);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ExperiencesCompanion toCompanion(bool nullToAbsent) {
    return ExperiencesCompanion(
      id: Value(id),
      company: Value(company),
      role: Value(role),
      startDate: Value(startDate),
      endDate: Value(endDate),
      isCurrent: Value(isCurrent),
      bulletsJson: Value(bulletsJson),
      sortOrder: Value(sortOrder),
    );
  }

  factory ExperienceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExperienceRow(
      id: serializer.fromJson<int>(json['id']),
      company: serializer.fromJson<String>(json['company']),
      role: serializer.fromJson<String>(json['role']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      isCurrent: serializer.fromJson<bool>(json['isCurrent']),
      bulletsJson: serializer.fromJson<String>(json['bulletsJson']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'company': serializer.toJson<String>(company),
      'role': serializer.toJson<String>(role),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'isCurrent': serializer.toJson<bool>(isCurrent),
      'bulletsJson': serializer.toJson<String>(bulletsJson),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ExperienceRow copyWith({
    int? id,
    String? company,
    String? role,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    String? bulletsJson,
    int? sortOrder,
  }) => ExperienceRow(
    id: id ?? this.id,
    company: company ?? this.company,
    role: role ?? this.role,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    isCurrent: isCurrent ?? this.isCurrent,
    bulletsJson: bulletsJson ?? this.bulletsJson,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ExperienceRow copyWithCompanion(ExperiencesCompanion data) {
    return ExperienceRow(
      id: data.id.present ? data.id.value : this.id,
      company: data.company.present ? data.company.value : this.company,
      role: data.role.present ? data.role.value : this.role,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
      bulletsJson: data.bulletsJson.present
          ? data.bulletsJson.value
          : this.bulletsJson,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExperienceRow(')
          ..write('id: $id, ')
          ..write('company: $company, ')
          ..write('role: $role, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('bulletsJson: $bulletsJson, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    company,
    role,
    startDate,
    endDate,
    isCurrent,
    bulletsJson,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExperienceRow &&
          other.id == this.id &&
          other.company == this.company &&
          other.role == this.role &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isCurrent == this.isCurrent &&
          other.bulletsJson == this.bulletsJson &&
          other.sortOrder == this.sortOrder);
}

class ExperiencesCompanion extends UpdateCompanion<ExperienceRow> {
  final Value<int> id;
  final Value<String> company;
  final Value<String> role;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<bool> isCurrent;
  final Value<String> bulletsJson;
  final Value<int> sortOrder;
  const ExperiencesCompanion({
    this.id = const Value.absent(),
    this.company = const Value.absent(),
    this.role = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.bulletsJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ExperiencesCompanion.insert({
    this.id = const Value.absent(),
    this.company = const Value.absent(),
    this.role = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.bulletsJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<ExperienceRow> custom({
    Expression<int>? id,
    Expression<String>? company,
    Expression<String>? role,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<bool>? isCurrent,
    Expression<String>? bulletsJson,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (company != null) 'company': company,
      if (role != null) 'role': role,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isCurrent != null) 'is_current': isCurrent,
      if (bulletsJson != null) 'bullets_json': bulletsJson,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ExperiencesCompanion copyWith({
    Value<int>? id,
    Value<String>? company,
    Value<String>? role,
    Value<String>? startDate,
    Value<String>? endDate,
    Value<bool>? isCurrent,
    Value<String>? bulletsJson,
    Value<int>? sortOrder,
  }) {
    return ExperiencesCompanion(
      id: id ?? this.id,
      company: company ?? this.company,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      bulletsJson: bulletsJson ?? this.bulletsJson,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (bulletsJson.present) {
      map['bullets_json'] = Variable<String>(bulletsJson.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperiencesCompanion(')
          ..write('id: $id, ')
          ..write('company: $company, ')
          ..write('role: $role, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('bulletsJson: $bulletsJson, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $EducationsTable extends Educations
    with TableInfo<$EducationsTable, EducationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EducationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
    'school',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _degreeMeta = const VerificationMeta('degree');
  @override
  late final GeneratedColumn<String> degree = GeneratedColumn<String>(
    'degree',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fieldMeta = const VerificationMeta('field');
  @override
  late final GeneratedColumn<String> field = GeneratedColumn<String>(
    'field',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    school,
    degree,
    field,
    startDate,
    endDate,
    details,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'educations';
  @override
  VerificationContext validateIntegrity(
    Insertable<EducationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('school')) {
      context.handle(
        _schoolMeta,
        school.isAcceptableOrUnknown(data['school']!, _schoolMeta),
      );
    }
    if (data.containsKey('degree')) {
      context.handle(
        _degreeMeta,
        degree.isAcceptableOrUnknown(data['degree']!, _degreeMeta),
      );
    }
    if (data.containsKey('field')) {
      context.handle(
        _fieldMeta,
        field.isAcceptableOrUnknown(data['field']!, _fieldMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EducationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EducationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      school: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school'],
      )!,
      degree: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}degree'],
      )!,
      field: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $EducationsTable createAlias(String alias) {
    return $EducationsTable(attachedDatabase, alias);
  }
}

class EducationRow extends DataClass implements Insertable<EducationRow> {
  final int id;
  final String school;
  final String degree;
  final String field;
  final String startDate;
  final String endDate;
  final String details;
  final int sortOrder;
  const EducationRow({
    required this.id,
    required this.school,
    required this.degree,
    required this.field,
    required this.startDate,
    required this.endDate,
    required this.details,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['school'] = Variable<String>(school);
    map['degree'] = Variable<String>(degree);
    map['field'] = Variable<String>(field);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['details'] = Variable<String>(details);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  EducationsCompanion toCompanion(bool nullToAbsent) {
    return EducationsCompanion(
      id: Value(id),
      school: Value(school),
      degree: Value(degree),
      field: Value(field),
      startDate: Value(startDate),
      endDate: Value(endDate),
      details: Value(details),
      sortOrder: Value(sortOrder),
    );
  }

  factory EducationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EducationRow(
      id: serializer.fromJson<int>(json['id']),
      school: serializer.fromJson<String>(json['school']),
      degree: serializer.fromJson<String>(json['degree']),
      field: serializer.fromJson<String>(json['field']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      details: serializer.fromJson<String>(json['details']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'school': serializer.toJson<String>(school),
      'degree': serializer.toJson<String>(degree),
      'field': serializer.toJson<String>(field),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'details': serializer.toJson<String>(details),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  EducationRow copyWith({
    int? id,
    String? school,
    String? degree,
    String? field,
    String? startDate,
    String? endDate,
    String? details,
    int? sortOrder,
  }) => EducationRow(
    id: id ?? this.id,
    school: school ?? this.school,
    degree: degree ?? this.degree,
    field: field ?? this.field,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    details: details ?? this.details,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  EducationRow copyWithCompanion(EducationsCompanion data) {
    return EducationRow(
      id: data.id.present ? data.id.value : this.id,
      school: data.school.present ? data.school.value : this.school,
      degree: data.degree.present ? data.degree.value : this.degree,
      field: data.field.present ? data.field.value : this.field,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      details: data.details.present ? data.details.value : this.details,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EducationRow(')
          ..write('id: $id, ')
          ..write('school: $school, ')
          ..write('degree: $degree, ')
          ..write('field: $field, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('details: $details, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    school,
    degree,
    field,
    startDate,
    endDate,
    details,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EducationRow &&
          other.id == this.id &&
          other.school == this.school &&
          other.degree == this.degree &&
          other.field == this.field &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.details == this.details &&
          other.sortOrder == this.sortOrder);
}

class EducationsCompanion extends UpdateCompanion<EducationRow> {
  final Value<int> id;
  final Value<String> school;
  final Value<String> degree;
  final Value<String> field;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<String> details;
  final Value<int> sortOrder;
  const EducationsCompanion({
    this.id = const Value.absent(),
    this.school = const Value.absent(),
    this.degree = const Value.absent(),
    this.field = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.details = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  EducationsCompanion.insert({
    this.id = const Value.absent(),
    this.school = const Value.absent(),
    this.degree = const Value.absent(),
    this.field = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.details = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<EducationRow> custom({
    Expression<int>? id,
    Expression<String>? school,
    Expression<String>? degree,
    Expression<String>? field,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? details,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (school != null) 'school': school,
      if (degree != null) 'degree': degree,
      if (field != null) 'field': field,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (details != null) 'details': details,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  EducationsCompanion copyWith({
    Value<int>? id,
    Value<String>? school,
    Value<String>? degree,
    Value<String>? field,
    Value<String>? startDate,
    Value<String>? endDate,
    Value<String>? details,
    Value<int>? sortOrder,
  }) {
    return EducationsCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (degree.present) {
      map['degree'] = Variable<String>(degree.value);
    }
    if (field.present) {
      map['field'] = Variable<String>(field.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EducationsCompanion(')
          ..write('id: $id, ')
          ..write('school: $school, ')
          ..write('degree: $degree, ')
          ..write('field: $field, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('details: $details, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $SkillGroupsTable extends SkillGroups
    with TableInfo<$SkillGroupsTable, SkillGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SkillGroupsTable createAlias(String alias) {
    return $SkillGroupsTable(attachedDatabase, alias);
  }
}

class SkillGroupRow extends DataClass implements Insertable<SkillGroupRow> {
  final int id;
  final String name;
  final int sortOrder;
  const SkillGroupRow({
    required this.id,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SkillGroupsCompanion toCompanion(bool nullToAbsent) {
    return SkillGroupsCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory SkillGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillGroupRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SkillGroupRow copyWith({int? id, String? name, int? sortOrder}) =>
      SkillGroupRow(
        id: id ?? this.id,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SkillGroupRow copyWithCompanion(SkillGroupsCompanion data) {
    return SkillGroupRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillGroupRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillGroupRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class SkillGroupsCompanion extends UpdateCompanion<SkillGroupRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortOrder;
  const SkillGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SkillGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<SkillGroupRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SkillGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? sortOrder,
  }) {
    return SkillGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $SkillsTable extends Skills with TableInfo<$SkillsTable, SkillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(attachedDatabase, alias);
  }
}

class SkillRow extends DataClass implements Insertable<SkillRow> {
  final int id;
  final int groupId;
  final String name;
  final int sortOrder;
  const SkillRow({
    required this.id,
    required this.groupId,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SkillsCompanion toCompanion(bool nullToAbsent) {
    return SkillsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory SkillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillRow(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SkillRow copyWith({int? id, int? groupId, String? name, int? sortOrder}) =>
      SkillRow(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SkillRow copyWithCompanion(SkillsCompanion data) {
    return SkillRow(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillRow(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillRow &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class SkillsCompanion extends UpdateCompanion<SkillRow> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;
  final Value<int> sortOrder;
  const SkillsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SkillsCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : groupId = Value(groupId);
  static Insertable<SkillRow> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SkillsCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<String>? name,
    Value<int>? sortOrder,
  }) {
    return SkillsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, CourseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _issuerMeta = const VerificationMeta('issuer');
  @override
  late final GeneratedColumn<String> issuer = GeneratedColumn<String>(
    'issuer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    issuer,
    date,
    url,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('issuer')) {
      context.handle(
        _issuerMeta,
        issuer.isAcceptableOrUnknown(data['issuer']!, _issuerMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      issuer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class CourseRow extends DataClass implements Insertable<CourseRow> {
  final int id;
  final String name;
  final String issuer;
  final String date;
  final String url;
  final int sortOrder;
  const CourseRow({
    required this.id,
    required this.name,
    required this.issuer,
    required this.date,
    required this.url,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['issuer'] = Variable<String>(issuer);
    map['date'] = Variable<String>(date);
    map['url'] = Variable<String>(url);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      name: Value(name),
      issuer: Value(issuer),
      date: Value(date),
      url: Value(url),
      sortOrder: Value(sortOrder),
    );
  }

  factory CourseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      issuer: serializer.fromJson<String>(json['issuer']),
      date: serializer.fromJson<String>(json['date']),
      url: serializer.fromJson<String>(json['url']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'issuer': serializer.toJson<String>(issuer),
      'date': serializer.toJson<String>(date),
      'url': serializer.toJson<String>(url),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CourseRow copyWith({
    int? id,
    String? name,
    String? issuer,
    String? date,
    String? url,
    int? sortOrder,
  }) => CourseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    issuer: issuer ?? this.issuer,
    date: date ?? this.date,
    url: url ?? this.url,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CourseRow copyWithCompanion(CoursesCompanion data) {
    return CourseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      issuer: data.issuer.present ? data.issuer.value : this.issuer,
      date: data.date.present ? data.date.value : this.date,
      url: data.url.present ? data.url.value : this.url,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('date: $date, ')
          ..write('url: $url, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, issuer, date, url, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.issuer == this.issuer &&
          other.date == this.date &&
          other.url == this.url &&
          other.sortOrder == this.sortOrder);
}

class CoursesCompanion extends UpdateCompanion<CourseRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> issuer;
  final Value<String> date;
  final Value<String> url;
  final Value<int> sortOrder;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.issuer = const Value.absent(),
    this.date = const Value.absent(),
    this.url = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.issuer = const Value.absent(),
    this.date = const Value.absent(),
    this.url = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<CourseRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? issuer,
    Expression<String>? date,
    Expression<String>? url,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (issuer != null) 'issuer': issuer,
      if (date != null) 'date': date,
      if (url != null) 'url': url,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  CoursesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? issuer,
    Value<String>? date,
    Value<String>? url,
    Value<int>? sortOrder,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      url: url ?? this.url,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (issuer.present) {
      map['issuer'] = Variable<String>(issuer.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('date: $date, ')
          ..write('url: $url, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _techStackMeta = const VerificationMeta(
    'techStack',
  );
  @override
  late final GeneratedColumn<String> techStack = GeneratedColumn<String>(
    'tech_stack',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bulletsJsonMeta = const VerificationMeta(
    'bulletsJson',
  );
  @override
  late final GeneratedColumn<String> bulletsJson = GeneratedColumn<String>(
    'bullets_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    link,
    description,
    techStack,
    bulletsJson,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('tech_stack')) {
      context.handle(
        _techStackMeta,
        techStack.isAcceptableOrUnknown(data['tech_stack']!, _techStackMeta),
      );
    }
    if (data.containsKey('bullets_json')) {
      context.handle(
        _bulletsJsonMeta,
        bulletsJson.isAcceptableOrUnknown(
          data['bullets_json']!,
          _bulletsJsonMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      techStack: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tech_stack'],
      )!,
      bulletsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bullets_json'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class ProjectRow extends DataClass implements Insertable<ProjectRow> {
  final int id;
  final String name;
  final String link;
  final String description;
  final String techStack;
  final String bulletsJson;
  final int sortOrder;
  const ProjectRow({
    required this.id,
    required this.name,
    required this.link,
    required this.description,
    required this.techStack,
    required this.bulletsJson,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['link'] = Variable<String>(link);
    map['description'] = Variable<String>(description);
    map['tech_stack'] = Variable<String>(techStack);
    map['bullets_json'] = Variable<String>(bulletsJson);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      link: Value(link),
      description: Value(description),
      techStack: Value(techStack),
      bulletsJson: Value(bulletsJson),
      sortOrder: Value(sortOrder),
    );
  }

  factory ProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      link: serializer.fromJson<String>(json['link']),
      description: serializer.fromJson<String>(json['description']),
      techStack: serializer.fromJson<String>(json['techStack']),
      bulletsJson: serializer.fromJson<String>(json['bulletsJson']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'link': serializer.toJson<String>(link),
      'description': serializer.toJson<String>(description),
      'techStack': serializer.toJson<String>(techStack),
      'bulletsJson': serializer.toJson<String>(bulletsJson),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ProjectRow copyWith({
    int? id,
    String? name,
    String? link,
    String? description,
    String? techStack,
    String? bulletsJson,
    int? sortOrder,
  }) => ProjectRow(
    id: id ?? this.id,
    name: name ?? this.name,
    link: link ?? this.link,
    description: description ?? this.description,
    techStack: techStack ?? this.techStack,
    bulletsJson: bulletsJson ?? this.bulletsJson,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ProjectRow copyWithCompanion(ProjectsCompanion data) {
    return ProjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      link: data.link.present ? data.link.value : this.link,
      description: data.description.present
          ? data.description.value
          : this.description,
      techStack: data.techStack.present ? data.techStack.value : this.techStack,
      bulletsJson: data.bulletsJson.present
          ? data.bulletsJson.value
          : this.bulletsJson,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('description: $description, ')
          ..write('techStack: $techStack, ')
          ..write('bulletsJson: $bulletsJson, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    link,
    description,
    techStack,
    bulletsJson,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.link == this.link &&
          other.description == this.description &&
          other.techStack == this.techStack &&
          other.bulletsJson == this.bulletsJson &&
          other.sortOrder == this.sortOrder);
}

class ProjectsCompanion extends UpdateCompanion<ProjectRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> link;
  final Value<String> description;
  final Value<String> techStack;
  final Value<String> bulletsJson;
  final Value<int> sortOrder;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.link = const Value.absent(),
    this.description = const Value.absent(),
    this.techStack = const Value.absent(),
    this.bulletsJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.link = const Value.absent(),
    this.description = const Value.absent(),
    this.techStack = const Value.absent(),
    this.bulletsJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<ProjectRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? link,
    Expression<String>? description,
    Expression<String>? techStack,
    Expression<String>? bulletsJson,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (link != null) 'link': link,
      if (description != null) 'description': description,
      if (techStack != null) 'tech_stack': techStack,
      if (bulletsJson != null) 'bullets_json': bulletsJson,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? link,
    Value<String>? description,
    Value<String>? techStack,
    Value<String>? bulletsJson,
    Value<int>? sortOrder,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      description: description ?? this.description,
      techStack: techStack ?? this.techStack,
      bulletsJson: bulletsJson ?? this.bulletsJson,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (techStack.present) {
      map['tech_stack'] = Variable<String>(techStack.value);
    }
    if (bulletsJson.present) {
      map['bullets_json'] = Variable<String>(bulletsJson.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('description: $description, ')
          ..write('techStack: $techStack, ')
          ..write('bulletsJson: $bulletsJson, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $LanguagesTable extends Languages
    with TableInfo<$LanguagesTable, LanguageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _proficiencyMeta = const VerificationMeta(
    'proficiency',
  );
  @override
  late final GeneratedColumn<String> proficiency = GeneratedColumn<String>(
    'proficiency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, proficiency, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'languages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LanguageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('proficiency')) {
      context.handle(
        _proficiencyMeta,
        proficiency.isAcceptableOrUnknown(
          data['proficiency']!,
          _proficiencyMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LanguageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LanguageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      proficiency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proficiency'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LanguagesTable createAlias(String alias) {
    return $LanguagesTable(attachedDatabase, alias);
  }
}

class LanguageRow extends DataClass implements Insertable<LanguageRow> {
  final int id;
  final String name;
  final String proficiency;
  final int sortOrder;
  const LanguageRow({
    required this.id,
    required this.name,
    required this.proficiency,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['proficiency'] = Variable<String>(proficiency);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      id: Value(id),
      name: Value(name),
      proficiency: Value(proficiency),
      sortOrder: Value(sortOrder),
    );
  }

  factory LanguageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LanguageRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      proficiency: serializer.fromJson<String>(json['proficiency']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'proficiency': serializer.toJson<String>(proficiency),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  LanguageRow copyWith({
    int? id,
    String? name,
    String? proficiency,
    int? sortOrder,
  }) => LanguageRow(
    id: id ?? this.id,
    name: name ?? this.name,
    proficiency: proficiency ?? this.proficiency,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  LanguageRow copyWithCompanion(LanguagesCompanion data) {
    return LanguageRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      proficiency: data.proficiency.present
          ? data.proficiency.value
          : this.proficiency,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LanguageRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('proficiency: $proficiency, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, proficiency, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LanguageRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.proficiency == this.proficiency &&
          other.sortOrder == this.sortOrder);
}

class LanguagesCompanion extends UpdateCompanion<LanguageRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> proficiency;
  final Value<int> sortOrder;
  const LanguagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.proficiency = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  LanguagesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.proficiency = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<LanguageRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? proficiency,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (proficiency != null) 'proficiency': proficiency,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  LanguagesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? proficiency,
    Value<int>? sortOrder,
  }) {
    return LanguagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      proficiency: proficiency ?? this.proficiency,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (proficiency.present) {
      map['proficiency'] = Variable<String>(proficiency.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('proficiency: $proficiency, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $AwardsTable extends Awards with TableInfo<$AwardsTable, AwardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AwardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _issuerMeta = const VerificationMeta('issuer');
  @override
  late final GeneratedColumn<String> issuer = GeneratedColumn<String>(
    'issuer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    issuer,
    date,
    description,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'awards';
  @override
  VerificationContext validateIntegrity(
    Insertable<AwardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('issuer')) {
      context.handle(
        _issuerMeta,
        issuer.isAcceptableOrUnknown(data['issuer']!, _issuerMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AwardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AwardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      issuer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $AwardsTable createAlias(String alias) {
    return $AwardsTable(attachedDatabase, alias);
  }
}

class AwardRow extends DataClass implements Insertable<AwardRow> {
  final int id;
  final String title;
  final String issuer;
  final String date;
  final String description;
  final int sortOrder;
  const AwardRow({
    required this.id,
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['issuer'] = Variable<String>(issuer);
    map['date'] = Variable<String>(date);
    map['description'] = Variable<String>(description);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AwardsCompanion toCompanion(bool nullToAbsent) {
    return AwardsCompanion(
      id: Value(id),
      title: Value(title),
      issuer: Value(issuer),
      date: Value(date),
      description: Value(description),
      sortOrder: Value(sortOrder),
    );
  }

  factory AwardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AwardRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      issuer: serializer.fromJson<String>(json['issuer']),
      date: serializer.fromJson<String>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'issuer': serializer.toJson<String>(issuer),
      'date': serializer.toJson<String>(date),
      'description': serializer.toJson<String>(description),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  AwardRow copyWith({
    int? id,
    String? title,
    String? issuer,
    String? date,
    String? description,
    int? sortOrder,
  }) => AwardRow(
    id: id ?? this.id,
    title: title ?? this.title,
    issuer: issuer ?? this.issuer,
    date: date ?? this.date,
    description: description ?? this.description,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  AwardRow copyWithCompanion(AwardsCompanion data) {
    return AwardRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      issuer: data.issuer.present ? data.issuer.value : this.issuer,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AwardRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('issuer: $issuer, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, issuer, date, description, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AwardRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.issuer == this.issuer &&
          other.date == this.date &&
          other.description == this.description &&
          other.sortOrder == this.sortOrder);
}

class AwardsCompanion extends UpdateCompanion<AwardRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> issuer;
  final Value<String> date;
  final Value<String> description;
  final Value<int> sortOrder;
  const AwardsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.issuer = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  AwardsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.issuer = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  static Insertable<AwardRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? issuer,
    Expression<String>? date,
    Expression<String>? description,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (issuer != null) 'issuer': issuer,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  AwardsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? issuer,
    Value<String>? date,
    Value<String>? description,
    Value<int>? sortOrder,
  }) {
    return AwardsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (issuer.present) {
      map['issuer'] = Variable<String>(issuer.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AwardsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('issuer: $issuer, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $CustomSectionsTable extends CustomSections
    with TableInfo<$CustomSectionsTable, CustomSectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isVisibleMeta = const VerificationMeta(
    'isVisible',
  );
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
    'is_visible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_visible" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, body, sortOrder, isVisible];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomSectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_visible')) {
      context.handle(
        _isVisibleMeta,
        isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomSectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomSectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isVisible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_visible'],
      )!,
    );
  }

  @override
  $CustomSectionsTable createAlias(String alias) {
    return $CustomSectionsTable(attachedDatabase, alias);
  }
}

class CustomSectionRow extends DataClass
    implements Insertable<CustomSectionRow> {
  final int id;
  final String title;
  final String body;
  final int sortOrder;
  final bool isVisible;
  const CustomSectionRow({
    required this.id,
    required this.title,
    required this.body,
    required this.sortOrder,
    required this.isVisible,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_visible'] = Variable<bool>(isVisible);
    return map;
  }

  CustomSectionsCompanion toCompanion(bool nullToAbsent) {
    return CustomSectionsCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      sortOrder: Value(sortOrder),
      isVisible: Value(isVisible),
    );
  }

  factory CustomSectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomSectionRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isVisible': serializer.toJson<bool>(isVisible),
    };
  }

  CustomSectionRow copyWith({
    int? id,
    String? title,
    String? body,
    int? sortOrder,
    bool? isVisible,
  }) => CustomSectionRow(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    sortOrder: sortOrder ?? this.sortOrder,
    isVisible: isVisible ?? this.isVisible,
  );
  CustomSectionRow copyWithCompanion(CustomSectionsCompanion data) {
    return CustomSectionRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomSectionRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isVisible: $isVisible')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, body, sortOrder, isVisible);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomSectionRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.sortOrder == this.sortOrder &&
          other.isVisible == this.isVisible);
}

class CustomSectionsCompanion extends UpdateCompanion<CustomSectionRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  final Value<int> sortOrder;
  final Value<bool> isVisible;
  const CustomSectionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isVisible = const Value.absent(),
  });
  CustomSectionsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isVisible = const Value.absent(),
  });
  static Insertable<CustomSectionRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? sortOrder,
    Expression<bool>? isVisible,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isVisible != null) 'is_visible': isVisible,
    });
  }

  CustomSectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? body,
    Value<int>? sortOrder,
    Value<bool>? isVisible,
  }) {
    return CustomSectionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      sortOrder: sortOrder ?? this.sortOrder,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomSectionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isVisible: $isVisible')
          ..write(')'))
        .toString();
  }
}

class $JobDescriptionsTable extends JobDescriptions
    with TableInfo<$JobDescriptionsTable, JobDescriptionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobDescriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rawTextMeta = const VerificationMeta(
    'rawText',
  );
  @override
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
    'raw_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _analyzedAtMeta = const VerificationMeta(
    'analyzedAt',
  );
  @override
  late final GeneratedColumn<DateTime> analyzedAt = GeneratedColumn<DateTime>(
    'analyzed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchScoreMeta = const VerificationMeta(
    'matchScore',
  );
  @override
  late final GeneratedColumn<double> matchScore = GeneratedColumn<double>(
    'match_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchedJsonMeta = const VerificationMeta(
    'matchedJson',
  );
  @override
  late final GeneratedColumn<String> matchedJson = GeneratedColumn<String>(
    'matched_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _missingJsonMeta = const VerificationMeta(
    'missingJson',
  );
  @override
  late final GeneratedColumn<String> missingJson = GeneratedColumn<String>(
    'missing_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawText,
    analyzedAt,
    matchScore,
    matchedJson,
    missingJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_descriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobDescriptionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    }
    if (data.containsKey('analyzed_at')) {
      context.handle(
        _analyzedAtMeta,
        analyzedAt.isAcceptableOrUnknown(data['analyzed_at']!, _analyzedAtMeta),
      );
    }
    if (data.containsKey('match_score')) {
      context.handle(
        _matchScoreMeta,
        matchScore.isAcceptableOrUnknown(data['match_score']!, _matchScoreMeta),
      );
    }
    if (data.containsKey('matched_json')) {
      context.handle(
        _matchedJsonMeta,
        matchedJson.isAcceptableOrUnknown(
          data['matched_json']!,
          _matchedJsonMeta,
        ),
      );
    }
    if (data.containsKey('missing_json')) {
      context.handle(
        _missingJsonMeta,
        missingJson.isAcceptableOrUnknown(
          data['missing_json']!,
          _missingJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobDescriptionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobDescriptionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      )!,
      analyzedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}analyzed_at'],
      ),
      matchScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}match_score'],
      ),
      matchedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matched_json'],
      )!,
      missingJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}missing_json'],
      )!,
    );
  }

  @override
  $JobDescriptionsTable createAlias(String alias) {
    return $JobDescriptionsTable(attachedDatabase, alias);
  }
}

class JobDescriptionRow extends DataClass
    implements Insertable<JobDescriptionRow> {
  final int id;
  final String rawText;
  final DateTime? analyzedAt;
  final double? matchScore;
  final String matchedJson;
  final String missingJson;
  const JobDescriptionRow({
    required this.id,
    required this.rawText,
    this.analyzedAt,
    this.matchScore,
    required this.matchedJson,
    required this.missingJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_text'] = Variable<String>(rawText);
    if (!nullToAbsent || analyzedAt != null) {
      map['analyzed_at'] = Variable<DateTime>(analyzedAt);
    }
    if (!nullToAbsent || matchScore != null) {
      map['match_score'] = Variable<double>(matchScore);
    }
    map['matched_json'] = Variable<String>(matchedJson);
    map['missing_json'] = Variable<String>(missingJson);
    return map;
  }

  JobDescriptionsCompanion toCompanion(bool nullToAbsent) {
    return JobDescriptionsCompanion(
      id: Value(id),
      rawText: Value(rawText),
      analyzedAt: analyzedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(analyzedAt),
      matchScore: matchScore == null && nullToAbsent
          ? const Value.absent()
          : Value(matchScore),
      matchedJson: Value(matchedJson),
      missingJson: Value(missingJson),
    );
  }

  factory JobDescriptionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobDescriptionRow(
      id: serializer.fromJson<int>(json['id']),
      rawText: serializer.fromJson<String>(json['rawText']),
      analyzedAt: serializer.fromJson<DateTime?>(json['analyzedAt']),
      matchScore: serializer.fromJson<double?>(json['matchScore']),
      matchedJson: serializer.fromJson<String>(json['matchedJson']),
      missingJson: serializer.fromJson<String>(json['missingJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawText': serializer.toJson<String>(rawText),
      'analyzedAt': serializer.toJson<DateTime?>(analyzedAt),
      'matchScore': serializer.toJson<double?>(matchScore),
      'matchedJson': serializer.toJson<String>(matchedJson),
      'missingJson': serializer.toJson<String>(missingJson),
    };
  }

  JobDescriptionRow copyWith({
    int? id,
    String? rawText,
    Value<DateTime?> analyzedAt = const Value.absent(),
    Value<double?> matchScore = const Value.absent(),
    String? matchedJson,
    String? missingJson,
  }) => JobDescriptionRow(
    id: id ?? this.id,
    rawText: rawText ?? this.rawText,
    analyzedAt: analyzedAt.present ? analyzedAt.value : this.analyzedAt,
    matchScore: matchScore.present ? matchScore.value : this.matchScore,
    matchedJson: matchedJson ?? this.matchedJson,
    missingJson: missingJson ?? this.missingJson,
  );
  JobDescriptionRow copyWithCompanion(JobDescriptionsCompanion data) {
    return JobDescriptionRow(
      id: data.id.present ? data.id.value : this.id,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      analyzedAt: data.analyzedAt.present
          ? data.analyzedAt.value
          : this.analyzedAt,
      matchScore: data.matchScore.present
          ? data.matchScore.value
          : this.matchScore,
      matchedJson: data.matchedJson.present
          ? data.matchedJson.value
          : this.matchedJson,
      missingJson: data.missingJson.present
          ? data.missingJson.value
          : this.missingJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobDescriptionRow(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('analyzedAt: $analyzedAt, ')
          ..write('matchScore: $matchScore, ')
          ..write('matchedJson: $matchedJson, ')
          ..write('missingJson: $missingJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawText,
    analyzedAt,
    matchScore,
    matchedJson,
    missingJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobDescriptionRow &&
          other.id == this.id &&
          other.rawText == this.rawText &&
          other.analyzedAt == this.analyzedAt &&
          other.matchScore == this.matchScore &&
          other.matchedJson == this.matchedJson &&
          other.missingJson == this.missingJson);
}

class JobDescriptionsCompanion extends UpdateCompanion<JobDescriptionRow> {
  final Value<int> id;
  final Value<String> rawText;
  final Value<DateTime?> analyzedAt;
  final Value<double?> matchScore;
  final Value<String> matchedJson;
  final Value<String> missingJson;
  const JobDescriptionsCompanion({
    this.id = const Value.absent(),
    this.rawText = const Value.absent(),
    this.analyzedAt = const Value.absent(),
    this.matchScore = const Value.absent(),
    this.matchedJson = const Value.absent(),
    this.missingJson = const Value.absent(),
  });
  JobDescriptionsCompanion.insert({
    this.id = const Value.absent(),
    this.rawText = const Value.absent(),
    this.analyzedAt = const Value.absent(),
    this.matchScore = const Value.absent(),
    this.matchedJson = const Value.absent(),
    this.missingJson = const Value.absent(),
  });
  static Insertable<JobDescriptionRow> custom({
    Expression<int>? id,
    Expression<String>? rawText,
    Expression<DateTime>? analyzedAt,
    Expression<double>? matchScore,
    Expression<String>? matchedJson,
    Expression<String>? missingJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawText != null) 'raw_text': rawText,
      if (analyzedAt != null) 'analyzed_at': analyzedAt,
      if (matchScore != null) 'match_score': matchScore,
      if (matchedJson != null) 'matched_json': matchedJson,
      if (missingJson != null) 'missing_json': missingJson,
    });
  }

  JobDescriptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? rawText,
    Value<DateTime?>? analyzedAt,
    Value<double?>? matchScore,
    Value<String>? matchedJson,
    Value<String>? missingJson,
  }) {
    return JobDescriptionsCompanion(
      id: id ?? this.id,
      rawText: rawText ?? this.rawText,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      matchScore: matchScore ?? this.matchScore,
      matchedJson: matchedJson ?? this.matchedJson,
      missingJson: missingJson ?? this.missingJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (analyzedAt.present) {
      map['analyzed_at'] = Variable<DateTime>(analyzedAt.value);
    }
    if (matchScore.present) {
      map['match_score'] = Variable<double>(matchScore.value);
    }
    if (matchedJson.present) {
      map['matched_json'] = Variable<String>(matchedJson.value);
    }
    if (missingJson.present) {
      map['missing_json'] = Variable<String>(missingJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobDescriptionsCompanion(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('analyzedAt: $analyzedAt, ')
          ..write('matchScore: $matchScore, ')
          ..write('matchedJson: $matchedJson, ')
          ..write('missingJson: $missingJson')
          ..write(')'))
        .toString();
  }
}

class $ResumeSettingsTableTable extends ResumeSettingsTable
    with TableInfo<$ResumeSettingsTableTable, ResumeSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResumeSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('classic'),
  );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<int> accentColor = GeneratedColumn<int>(
    'accent_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF0F766E),
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('inter'),
  );
  static const VerificationMeta _fontSizeMeta = const VerificationMeta(
    'fontSize',
  );
  @override
  late final GeneratedColumn<double> fontSize = GeneratedColumn<double>(
    'font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10.0),
  );
  static const VerificationMeta _marginMeta = const VerificationMeta('margin');
  @override
  late final GeneratedColumn<double> margin = GeneratedColumn<double>(
    'margin',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40.0),
  );
  static const VerificationMeta _sectionOrderJsonMeta = const VerificationMeta(
    'sectionOrderJson',
  );
  @override
  late final GeneratedColumn<String> sectionOrderJson = GeneratedColumn<String>(
    'section_order_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _sectionVisibilityJsonMeta =
      const VerificationMeta('sectionVisibilityJson');
  @override
  late final GeneratedColumn<String> sectionVisibilityJson =
      GeneratedColumn<String>(
        'section_visibility_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _hasSeenOnboardingMeta = const VerificationMeta(
    'hasSeenOnboarding',
  );
  @override
  late final GeneratedColumn<bool> hasSeenOnboarding = GeneratedColumn<bool>(
    'has_seen_onboarding',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_seen_onboarding" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    accentColor,
    fontFamily,
    fontSize,
    margin,
    sectionOrderJson,
    sectionVisibilityJson,
    hasSeenOnboarding,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'resume_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResumeSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    }
    if (data.containsKey('font_size')) {
      context.handle(
        _fontSizeMeta,
        fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta),
      );
    }
    if (data.containsKey('margin')) {
      context.handle(
        _marginMeta,
        margin.isAcceptableOrUnknown(data['margin']!, _marginMeta),
      );
    }
    if (data.containsKey('section_order_json')) {
      context.handle(
        _sectionOrderJsonMeta,
        sectionOrderJson.isAcceptableOrUnknown(
          data['section_order_json']!,
          _sectionOrderJsonMeta,
        ),
      );
    }
    if (data.containsKey('section_visibility_json')) {
      context.handle(
        _sectionVisibilityJsonMeta,
        sectionVisibilityJson.isAcceptableOrUnknown(
          data['section_visibility_json']!,
          _sectionVisibilityJsonMeta,
        ),
      );
    }
    if (data.containsKey('has_seen_onboarding')) {
      context.handle(
        _hasSeenOnboardingMeta,
        hasSeenOnboarding.isAcceptableOrUnknown(
          data['has_seen_onboarding']!,
          _hasSeenOnboardingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResumeSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResumeSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accent_color'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      fontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}font_size'],
      )!,
      margin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}margin'],
      )!,
      sectionOrderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_order_json'],
      )!,
      sectionVisibilityJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_visibility_json'],
      )!,
      hasSeenOnboarding: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_seen_onboarding'],
      )!,
    );
  }

  @override
  $ResumeSettingsTableTable createAlias(String alias) {
    return $ResumeSettingsTableTable(attachedDatabase, alias);
  }
}

class ResumeSettingsRow extends DataClass
    implements Insertable<ResumeSettingsRow> {
  final int id;
  final String templateId;
  final int accentColor;
  final String fontFamily;
  final double fontSize;
  final double margin;
  final String sectionOrderJson;
  final String sectionVisibilityJson;
  final bool hasSeenOnboarding;
  const ResumeSettingsRow({
    required this.id,
    required this.templateId,
    required this.accentColor,
    required this.fontFamily,
    required this.fontSize,
    required this.margin,
    required this.sectionOrderJson,
    required this.sectionVisibilityJson,
    required this.hasSeenOnboarding,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<String>(templateId);
    map['accent_color'] = Variable<int>(accentColor);
    map['font_family'] = Variable<String>(fontFamily);
    map['font_size'] = Variable<double>(fontSize);
    map['margin'] = Variable<double>(margin);
    map['section_order_json'] = Variable<String>(sectionOrderJson);
    map['section_visibility_json'] = Variable<String>(sectionVisibilityJson);
    map['has_seen_onboarding'] = Variable<bool>(hasSeenOnboarding);
    return map;
  }

  ResumeSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return ResumeSettingsTableCompanion(
      id: Value(id),
      templateId: Value(templateId),
      accentColor: Value(accentColor),
      fontFamily: Value(fontFamily),
      fontSize: Value(fontSize),
      margin: Value(margin),
      sectionOrderJson: Value(sectionOrderJson),
      sectionVisibilityJson: Value(sectionVisibilityJson),
      hasSeenOnboarding: Value(hasSeenOnboarding),
    );
  }

  factory ResumeSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResumeSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      accentColor: serializer.fromJson<int>(json['accentColor']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      fontSize: serializer.fromJson<double>(json['fontSize']),
      margin: serializer.fromJson<double>(json['margin']),
      sectionOrderJson: serializer.fromJson<String>(json['sectionOrderJson']),
      sectionVisibilityJson: serializer.fromJson<String>(
        json['sectionVisibilityJson'],
      ),
      hasSeenOnboarding: serializer.fromJson<bool>(json['hasSeenOnboarding']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<String>(templateId),
      'accentColor': serializer.toJson<int>(accentColor),
      'fontFamily': serializer.toJson<String>(fontFamily),
      'fontSize': serializer.toJson<double>(fontSize),
      'margin': serializer.toJson<double>(margin),
      'sectionOrderJson': serializer.toJson<String>(sectionOrderJson),
      'sectionVisibilityJson': serializer.toJson<String>(sectionVisibilityJson),
      'hasSeenOnboarding': serializer.toJson<bool>(hasSeenOnboarding),
    };
  }

  ResumeSettingsRow copyWith({
    int? id,
    String? templateId,
    int? accentColor,
    String? fontFamily,
    double? fontSize,
    double? margin,
    String? sectionOrderJson,
    String? sectionVisibilityJson,
    bool? hasSeenOnboarding,
  }) => ResumeSettingsRow(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    accentColor: accentColor ?? this.accentColor,
    fontFamily: fontFamily ?? this.fontFamily,
    fontSize: fontSize ?? this.fontSize,
    margin: margin ?? this.margin,
    sectionOrderJson: sectionOrderJson ?? this.sectionOrderJson,
    sectionVisibilityJson: sectionVisibilityJson ?? this.sectionVisibilityJson,
    hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
  );
  ResumeSettingsRow copyWithCompanion(ResumeSettingsTableCompanion data) {
    return ResumeSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      fontSize: data.fontSize.present ? data.fontSize.value : this.fontSize,
      margin: data.margin.present ? data.margin.value : this.margin,
      sectionOrderJson: data.sectionOrderJson.present
          ? data.sectionOrderJson.value
          : this.sectionOrderJson,
      sectionVisibilityJson: data.sectionVisibilityJson.present
          ? data.sectionVisibilityJson.value
          : this.sectionVisibilityJson,
      hasSeenOnboarding: data.hasSeenOnboarding.present
          ? data.hasSeenOnboarding.value
          : this.hasSeenOnboarding,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResumeSettingsRow(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSize: $fontSize, ')
          ..write('margin: $margin, ')
          ..write('sectionOrderJson: $sectionOrderJson, ')
          ..write('sectionVisibilityJson: $sectionVisibilityJson, ')
          ..write('hasSeenOnboarding: $hasSeenOnboarding')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    accentColor,
    fontFamily,
    fontSize,
    margin,
    sectionOrderJson,
    sectionVisibilityJson,
    hasSeenOnboarding,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResumeSettingsRow &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.accentColor == this.accentColor &&
          other.fontFamily == this.fontFamily &&
          other.fontSize == this.fontSize &&
          other.margin == this.margin &&
          other.sectionOrderJson == this.sectionOrderJson &&
          other.sectionVisibilityJson == this.sectionVisibilityJson &&
          other.hasSeenOnboarding == this.hasSeenOnboarding);
}

class ResumeSettingsTableCompanion extends UpdateCompanion<ResumeSettingsRow> {
  final Value<int> id;
  final Value<String> templateId;
  final Value<int> accentColor;
  final Value<String> fontFamily;
  final Value<double> fontSize;
  final Value<double> margin;
  final Value<String> sectionOrderJson;
  final Value<String> sectionVisibilityJson;
  final Value<bool> hasSeenOnboarding;
  const ResumeSettingsTableCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.margin = const Value.absent(),
    this.sectionOrderJson = const Value.absent(),
    this.sectionVisibilityJson = const Value.absent(),
    this.hasSeenOnboarding = const Value.absent(),
  });
  ResumeSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.margin = const Value.absent(),
    this.sectionOrderJson = const Value.absent(),
    this.sectionVisibilityJson = const Value.absent(),
    this.hasSeenOnboarding = const Value.absent(),
  });
  static Insertable<ResumeSettingsRow> custom({
    Expression<int>? id,
    Expression<String>? templateId,
    Expression<int>? accentColor,
    Expression<String>? fontFamily,
    Expression<double>? fontSize,
    Expression<double>? margin,
    Expression<String>? sectionOrderJson,
    Expression<String>? sectionVisibilityJson,
    Expression<bool>? hasSeenOnboarding,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (accentColor != null) 'accent_color': accentColor,
      if (fontFamily != null) 'font_family': fontFamily,
      if (fontSize != null) 'font_size': fontSize,
      if (margin != null) 'margin': margin,
      if (sectionOrderJson != null) 'section_order_json': sectionOrderJson,
      if (sectionVisibilityJson != null)
        'section_visibility_json': sectionVisibilityJson,
      if (hasSeenOnboarding != null) 'has_seen_onboarding': hasSeenOnboarding,
    });
  }

  ResumeSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? templateId,
    Value<int>? accentColor,
    Value<String>? fontFamily,
    Value<double>? fontSize,
    Value<double>? margin,
    Value<String>? sectionOrderJson,
    Value<String>? sectionVisibilityJson,
    Value<bool>? hasSeenOnboarding,
  }) {
    return ResumeSettingsTableCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      margin: margin ?? this.margin,
      sectionOrderJson: sectionOrderJson ?? this.sectionOrderJson,
      sectionVisibilityJson:
          sectionVisibilityJson ?? this.sectionVisibilityJson,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<int>(accentColor.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (fontSize.present) {
      map['font_size'] = Variable<double>(fontSize.value);
    }
    if (margin.present) {
      map['margin'] = Variable<double>(margin.value);
    }
    if (sectionOrderJson.present) {
      map['section_order_json'] = Variable<String>(sectionOrderJson.value);
    }
    if (sectionVisibilityJson.present) {
      map['section_visibility_json'] = Variable<String>(
        sectionVisibilityJson.value,
      );
    }
    if (hasSeenOnboarding.present) {
      map['has_seen_onboarding'] = Variable<bool>(hasSeenOnboarding.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResumeSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSize: $fontSize, ')
          ..write('margin: $margin, ')
          ..write('sectionOrderJson: $sectionOrderJson, ')
          ..write('sectionVisibilityJson: $sectionVisibilityJson, ')
          ..write('hasSeenOnboarding: $hasSeenOnboarding')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonalInfoTableTable personalInfoTable =
      $PersonalInfoTableTable(this);
  late final $SummaryTableTable summaryTable = $SummaryTableTable(this);
  late final $ExperiencesTable experiences = $ExperiencesTable(this);
  late final $EducationsTable educations = $EducationsTable(this);
  late final $SkillGroupsTable skillGroups = $SkillGroupsTable(this);
  late final $SkillsTable skills = $SkillsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $LanguagesTable languages = $LanguagesTable(this);
  late final $AwardsTable awards = $AwardsTable(this);
  late final $CustomSectionsTable customSections = $CustomSectionsTable(this);
  late final $JobDescriptionsTable jobDescriptions = $JobDescriptionsTable(
    this,
  );
  late final $ResumeSettingsTableTable resumeSettingsTable =
      $ResumeSettingsTableTable(this);
  late final ProfileDao profileDao = ProfileDao(this as AppDatabase);
  late final JobDescriptionDao jobDescriptionDao = JobDescriptionDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    personalInfoTable,
    summaryTable,
    experiences,
    educations,
    skillGroups,
    skills,
    courses,
    projects,
    languages,
    awards,
    customSections,
    jobDescriptions,
    resumeSettingsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'skill_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('skills', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PersonalInfoTableTableCreateCompanionBuilder =
    PersonalInfoTableCompanion Function({
      Value<int> id,
      Value<String> fullName,
      Value<String> title,
      Value<String> email,
      Value<String> phone,
      Value<String> location,
      Value<String> linkedin,
      Value<String> github,
      Value<String> portfolio,
    });
typedef $$PersonalInfoTableTableUpdateCompanionBuilder =
    PersonalInfoTableCompanion Function({
      Value<int> id,
      Value<String> fullName,
      Value<String> title,
      Value<String> email,
      Value<String> phone,
      Value<String> location,
      Value<String> linkedin,
      Value<String> github,
      Value<String> portfolio,
    });

class $$PersonalInfoTableTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalInfoTableTable> {
  $$PersonalInfoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedin => $composableBuilder(
    column: $table.linkedin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get github => $composableBuilder(
    column: $table.github,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portfolio => $composableBuilder(
    column: $table.portfolio,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalInfoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalInfoTableTable> {
  $$PersonalInfoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedin => $composableBuilder(
    column: $table.linkedin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get github => $composableBuilder(
    column: $table.github,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portfolio => $composableBuilder(
    column: $table.portfolio,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalInfoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalInfoTableTable> {
  $$PersonalInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get linkedin =>
      $composableBuilder(column: $table.linkedin, builder: (column) => column);

  GeneratedColumn<String> get github =>
      $composableBuilder(column: $table.github, builder: (column) => column);

  GeneratedColumn<String> get portfolio =>
      $composableBuilder(column: $table.portfolio, builder: (column) => column);
}

class $$PersonalInfoTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalInfoTableTable,
          PersonalInfoRow,
          $$PersonalInfoTableTableFilterComposer,
          $$PersonalInfoTableTableOrderingComposer,
          $$PersonalInfoTableTableAnnotationComposer,
          $$PersonalInfoTableTableCreateCompanionBuilder,
          $$PersonalInfoTableTableUpdateCompanionBuilder,
          (
            PersonalInfoRow,
            BaseReferences<
              _$AppDatabase,
              $PersonalInfoTableTable,
              PersonalInfoRow
            >,
          ),
          PersonalInfoRow,
          PrefetchHooks Function()
        > {
  $$PersonalInfoTableTableTableManager(
    _$AppDatabase db,
    $PersonalInfoTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalInfoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalInfoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalInfoTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> linkedin = const Value.absent(),
                Value<String> github = const Value.absent(),
                Value<String> portfolio = const Value.absent(),
              }) => PersonalInfoTableCompanion(
                id: id,
                fullName: fullName,
                title: title,
                email: email,
                phone: phone,
                location: location,
                linkedin: linkedin,
                github: github,
                portfolio: portfolio,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> linkedin = const Value.absent(),
                Value<String> github = const Value.absent(),
                Value<String> portfolio = const Value.absent(),
              }) => PersonalInfoTableCompanion.insert(
                id: id,
                fullName: fullName,
                title: title,
                email: email,
                phone: phone,
                location: location,
                linkedin: linkedin,
                github: github,
                portfolio: portfolio,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalInfoTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalInfoTableTable,
      PersonalInfoRow,
      $$PersonalInfoTableTableFilterComposer,
      $$PersonalInfoTableTableOrderingComposer,
      $$PersonalInfoTableTableAnnotationComposer,
      $$PersonalInfoTableTableCreateCompanionBuilder,
      $$PersonalInfoTableTableUpdateCompanionBuilder,
      (
        PersonalInfoRow,
        BaseReferences<_$AppDatabase, $PersonalInfoTableTable, PersonalInfoRow>,
      ),
      PersonalInfoRow,
      PrefetchHooks Function()
    >;
typedef $$SummaryTableTableCreateCompanionBuilder =
    SummaryTableCompanion Function({Value<int> id, Value<String> body});
typedef $$SummaryTableTableUpdateCompanionBuilder =
    SummaryTableCompanion Function({Value<int> id, Value<String> body});

class $$SummaryTableTableFilterComposer
    extends Composer<_$AppDatabase, $SummaryTableTable> {
  $$SummaryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SummaryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SummaryTableTable> {
  $$SummaryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SummaryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SummaryTableTable> {
  $$SummaryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);
}

class $$SummaryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SummaryTableTable,
          SummaryRow,
          $$SummaryTableTableFilterComposer,
          $$SummaryTableTableOrderingComposer,
          $$SummaryTableTableAnnotationComposer,
          $$SummaryTableTableCreateCompanionBuilder,
          $$SummaryTableTableUpdateCompanionBuilder,
          (
            SummaryRow,
            BaseReferences<_$AppDatabase, $SummaryTableTable, SummaryRow>,
          ),
          SummaryRow,
          PrefetchHooks Function()
        > {
  $$SummaryTableTableTableManager(_$AppDatabase db, $SummaryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SummaryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SummaryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SummaryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> body = const Value.absent(),
              }) => SummaryTableCompanion(id: id, body: body),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> body = const Value.absent(),
              }) => SummaryTableCompanion.insert(id: id, body: body),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SummaryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SummaryTableTable,
      SummaryRow,
      $$SummaryTableTableFilterComposer,
      $$SummaryTableTableOrderingComposer,
      $$SummaryTableTableAnnotationComposer,
      $$SummaryTableTableCreateCompanionBuilder,
      $$SummaryTableTableUpdateCompanionBuilder,
      (
        SummaryRow,
        BaseReferences<_$AppDatabase, $SummaryTableTable, SummaryRow>,
      ),
      SummaryRow,
      PrefetchHooks Function()
    >;
typedef $$ExperiencesTableCreateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      Value<String> company,
      Value<String> role,
      Value<String> startDate,
      Value<String> endDate,
      Value<bool> isCurrent,
      Value<String> bulletsJson,
      Value<int> sortOrder,
    });
typedef $$ExperiencesTableUpdateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      Value<String> company,
      Value<String> role,
      Value<String> startDate,
      Value<String> endDate,
      Value<bool> isCurrent,
      Value<String> bulletsJson,
      Value<int> sortOrder,
    });

class $$ExperiencesTableFilterComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExperiencesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExperiencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  GeneratedColumn<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ExperiencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExperiencesTable,
          ExperienceRow,
          $$ExperiencesTableFilterComposer,
          $$ExperiencesTableOrderingComposer,
          $$ExperiencesTableAnnotationComposer,
          $$ExperiencesTableCreateCompanionBuilder,
          $$ExperiencesTableUpdateCompanionBuilder,
          (
            ExperienceRow,
            BaseReferences<_$AppDatabase, $ExperiencesTable, ExperienceRow>,
          ),
          ExperienceRow,
          PrefetchHooks Function()
        > {
  $$ExperiencesTableTableManager(_$AppDatabase db, $ExperiencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExperiencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExperiencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExperiencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> company = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<String> bulletsJson = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ExperiencesCompanion(
                id: id,
                company: company,
                role: role,
                startDate: startDate,
                endDate: endDate,
                isCurrent: isCurrent,
                bulletsJson: bulletsJson,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> company = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<String> bulletsJson = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ExperiencesCompanion.insert(
                id: id,
                company: company,
                role: role,
                startDate: startDate,
                endDate: endDate,
                isCurrent: isCurrent,
                bulletsJson: bulletsJson,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExperiencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExperiencesTable,
      ExperienceRow,
      $$ExperiencesTableFilterComposer,
      $$ExperiencesTableOrderingComposer,
      $$ExperiencesTableAnnotationComposer,
      $$ExperiencesTableCreateCompanionBuilder,
      $$ExperiencesTableUpdateCompanionBuilder,
      (
        ExperienceRow,
        BaseReferences<_$AppDatabase, $ExperiencesTable, ExperienceRow>,
      ),
      ExperienceRow,
      PrefetchHooks Function()
    >;
typedef $$EducationsTableCreateCompanionBuilder =
    EducationsCompanion Function({
      Value<int> id,
      Value<String> school,
      Value<String> degree,
      Value<String> field,
      Value<String> startDate,
      Value<String> endDate,
      Value<String> details,
      Value<int> sortOrder,
    });
typedef $$EducationsTableUpdateCompanionBuilder =
    EducationsCompanion Function({
      Value<int> id,
      Value<String> school,
      Value<String> degree,
      Value<String> field,
      Value<String> startDate,
      Value<String> endDate,
      Value<String> details,
      Value<int> sortOrder,
    });

class $$EducationsTableFilterComposer
    extends Composer<_$AppDatabase, $EducationsTable> {
  $$EducationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get degree => $composableBuilder(
    column: $table.degree,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EducationsTableOrderingComposer
    extends Composer<_$AppDatabase, $EducationsTable> {
  $$EducationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get degree => $composableBuilder(
    column: $table.degree,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EducationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EducationsTable> {
  $$EducationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get degree =>
      $composableBuilder(column: $table.degree, builder: (column) => column);

  GeneratedColumn<String> get field =>
      $composableBuilder(column: $table.field, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$EducationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EducationsTable,
          EducationRow,
          $$EducationsTableFilterComposer,
          $$EducationsTableOrderingComposer,
          $$EducationsTableAnnotationComposer,
          $$EducationsTableCreateCompanionBuilder,
          $$EducationsTableUpdateCompanionBuilder,
          (
            EducationRow,
            BaseReferences<_$AppDatabase, $EducationsTable, EducationRow>,
          ),
          EducationRow,
          PrefetchHooks Function()
        > {
  $$EducationsTableTableManager(_$AppDatabase db, $EducationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EducationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EducationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EducationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> school = const Value.absent(),
                Value<String> degree = const Value.absent(),
                Value<String> field = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => EducationsCompanion(
                id: id,
                school: school,
                degree: degree,
                field: field,
                startDate: startDate,
                endDate: endDate,
                details: details,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> school = const Value.absent(),
                Value<String> degree = const Value.absent(),
                Value<String> field = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => EducationsCompanion.insert(
                id: id,
                school: school,
                degree: degree,
                field: field,
                startDate: startDate,
                endDate: endDate,
                details: details,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EducationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EducationsTable,
      EducationRow,
      $$EducationsTableFilterComposer,
      $$EducationsTableOrderingComposer,
      $$EducationsTableAnnotationComposer,
      $$EducationsTableCreateCompanionBuilder,
      $$EducationsTableUpdateCompanionBuilder,
      (
        EducationRow,
        BaseReferences<_$AppDatabase, $EducationsTable, EducationRow>,
      ),
      EducationRow,
      PrefetchHooks Function()
    >;
typedef $$SkillGroupsTableCreateCompanionBuilder =
    SkillGroupsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> sortOrder,
    });
typedef $$SkillGroupsTableUpdateCompanionBuilder =
    SkillGroupsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> sortOrder,
    });

final class $$SkillGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $SkillGroupsTable, SkillGroupRow> {
  $$SkillGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SkillsTable, List<SkillRow>> _skillsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.skills,
    aliasName: 'skill_groups__id__skills__group_id',
  );

  $$SkillsTableProcessedTableManager get skillsRefs {
    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_skillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillGroupsTable> {
  $$SkillGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> skillsRefs(
    Expression<bool> Function($$SkillsTableFilterComposer f) f,
  ) {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillGroupsTable> {
  $$SkillGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillGroupsTable> {
  $$SkillGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> skillsRefs<T extends Object>(
    Expression<T> Function($$SkillsTableAnnotationComposer a) f,
  ) {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillGroupsTable,
          SkillGroupRow,
          $$SkillGroupsTableFilterComposer,
          $$SkillGroupsTableOrderingComposer,
          $$SkillGroupsTableAnnotationComposer,
          $$SkillGroupsTableCreateCompanionBuilder,
          $$SkillGroupsTableUpdateCompanionBuilder,
          (SkillGroupRow, $$SkillGroupsTableReferences),
          SkillGroupRow,
          PrefetchHooks Function({bool skillsRefs})
        > {
  $$SkillGroupsTableTableManager(_$AppDatabase db, $SkillGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SkillGroupsCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SkillGroupsCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkillGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({skillsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (skillsRefs) db.skills],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (skillsRefs)
                    await $_getPrefetchedData<
                      SkillGroupRow,
                      $SkillGroupsTable,
                      SkillRow
                    >(
                      currentTable: table,
                      referencedTable: $$SkillGroupsTableReferences
                          ._skillsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SkillGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).skillsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SkillGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillGroupsTable,
      SkillGroupRow,
      $$SkillGroupsTableFilterComposer,
      $$SkillGroupsTableOrderingComposer,
      $$SkillGroupsTableAnnotationComposer,
      $$SkillGroupsTableCreateCompanionBuilder,
      $$SkillGroupsTableUpdateCompanionBuilder,
      (SkillGroupRow, $$SkillGroupsTableReferences),
      SkillGroupRow,
      PrefetchHooks Function({bool skillsRefs})
    >;
typedef $$SkillsTableCreateCompanionBuilder =
    SkillsCompanion Function({
      Value<int> id,
      required int groupId,
      Value<String> name,
      Value<int> sortOrder,
    });
typedef $$SkillsTableUpdateCompanionBuilder =
    SkillsCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<String> name,
      Value<int> sortOrder,
    });

final class $$SkillsTableReferences
    extends BaseReferences<_$AppDatabase, $SkillsTable, SkillRow> {
  $$SkillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.skillGroups.createAlias('skills__group_id__skill_groups__id');

  $$SkillGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$SkillGroupsTableTableManager(
      $_db,
      $_db.skillGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SkillsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillGroupsTableFilterComposer get groupId {
    final $$SkillGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.skillGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillGroupsTableFilterComposer(
            $db: $db,
            $table: $db.skillGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillGroupsTableOrderingComposer get groupId {
    final $$SkillGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.skillGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.skillGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SkillGroupsTableAnnotationComposer get groupId {
    final $$SkillGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.skillGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.skillGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillsTable,
          SkillRow,
          $$SkillsTableFilterComposer,
          $$SkillsTableOrderingComposer,
          $$SkillsTableAnnotationComposer,
          $$SkillsTableCreateCompanionBuilder,
          $$SkillsTableUpdateCompanionBuilder,
          (SkillRow, $$SkillsTableReferences),
          SkillRow,
          PrefetchHooks Function({bool groupId})
        > {
  $$SkillsTableTableManager(_$AppDatabase db, $SkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SkillsCompanion(
                id: id,
                groupId: groupId,
                name: name,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SkillsCompanion.insert(
                id: id,
                groupId: groupId,
                name: name,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SkillsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $$SkillsTableReferences
                                    ._groupIdTable(db),
                                referencedColumn: $$SkillsTableReferences
                                    ._groupIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillsTable,
      SkillRow,
      $$SkillsTableFilterComposer,
      $$SkillsTableOrderingComposer,
      $$SkillsTableAnnotationComposer,
      $$SkillsTableCreateCompanionBuilder,
      $$SkillsTableUpdateCompanionBuilder,
      (SkillRow, $$SkillsTableReferences),
      SkillRow,
      PrefetchHooks Function({bool groupId})
    >;
typedef $$CoursesTableCreateCompanionBuilder =
    CoursesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> issuer,
      Value<String> date,
      Value<String> url,
      Value<int> sortOrder,
    });
typedef $$CoursesTableUpdateCompanionBuilder =
    CoursesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> issuer,
      Value<String> date,
      Value<String> url,
      Value<int> sortOrder,
    });

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get issuer =>
      $composableBuilder(column: $table.issuer, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursesTable,
          CourseRow,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (CourseRow, BaseReferences<_$AppDatabase, $CoursesTable, CourseRow>),
          CourseRow,
          PrefetchHooks Function()
        > {
  $$CoursesTableTableManager(_$AppDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> issuer = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                name: name,
                issuer: issuer,
                date: date,
                url: url,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> issuer = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                name: name,
                issuer: issuer,
                date: date,
                url: url,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursesTable,
      CourseRow,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (CourseRow, BaseReferences<_$AppDatabase, $CoursesTable, CourseRow>),
      CourseRow,
      PrefetchHooks Function()
    >;
typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> link,
      Value<String> description,
      Value<String> techStack,
      Value<String> bulletsJson,
      Value<int> sortOrder,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> link,
      Value<String> description,
      Value<String> techStack,
      Value<String> bulletsJson,
      Value<int> sortOrder,
    });

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techStack => $composableBuilder(
    column: $table.techStack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techStack => $composableBuilder(
    column: $table.techStack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get techStack =>
      $composableBuilder(column: $table.techStack, builder: (column) => column);

  GeneratedColumn<String> get bulletsJson => $composableBuilder(
    column: $table.bulletsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          ProjectRow,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (
            ProjectRow,
            BaseReferences<_$AppDatabase, $ProjectsTable, ProjectRow>,
          ),
          ProjectRow,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> techStack = const Value.absent(),
                Value<String> bulletsJson = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                link: link,
                description: description,
                techStack: techStack,
                bulletsJson: bulletsJson,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> techStack = const Value.absent(),
                Value<String> bulletsJson = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                link: link,
                description: description,
                techStack: techStack,
                bulletsJson: bulletsJson,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      ProjectRow,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (ProjectRow, BaseReferences<_$AppDatabase, $ProjectsTable, ProjectRow>),
      ProjectRow,
      PrefetchHooks Function()
    >;
typedef $$LanguagesTableCreateCompanionBuilder =
    LanguagesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> proficiency,
      Value<int> sortOrder,
    });
typedef $$LanguagesTableUpdateCompanionBuilder =
    LanguagesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> proficiency,
      Value<int> sortOrder,
    });

class $$LanguagesTableFilterComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LanguagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LanguagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$LanguagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LanguagesTable,
          LanguageRow,
          $$LanguagesTableFilterComposer,
          $$LanguagesTableOrderingComposer,
          $$LanguagesTableAnnotationComposer,
          $$LanguagesTableCreateCompanionBuilder,
          $$LanguagesTableUpdateCompanionBuilder,
          (
            LanguageRow,
            BaseReferences<_$AppDatabase, $LanguagesTable, LanguageRow>,
          ),
          LanguageRow,
          PrefetchHooks Function()
        > {
  $$LanguagesTableTableManager(_$AppDatabase db, $LanguagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LanguagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LanguagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LanguagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> proficiency = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => LanguagesCompanion(
                id: id,
                name: name,
                proficiency: proficiency,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> proficiency = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => LanguagesCompanion.insert(
                id: id,
                name: name,
                proficiency: proficiency,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LanguagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LanguagesTable,
      LanguageRow,
      $$LanguagesTableFilterComposer,
      $$LanguagesTableOrderingComposer,
      $$LanguagesTableAnnotationComposer,
      $$LanguagesTableCreateCompanionBuilder,
      $$LanguagesTableUpdateCompanionBuilder,
      (
        LanguageRow,
        BaseReferences<_$AppDatabase, $LanguagesTable, LanguageRow>,
      ),
      LanguageRow,
      PrefetchHooks Function()
    >;
typedef $$AwardsTableCreateCompanionBuilder =
    AwardsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> issuer,
      Value<String> date,
      Value<String> description,
      Value<int> sortOrder,
    });
typedef $$AwardsTableUpdateCompanionBuilder =
    AwardsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> issuer,
      Value<String> date,
      Value<String> description,
      Value<int> sortOrder,
    });

class $$AwardsTableFilterComposer
    extends Composer<_$AppDatabase, $AwardsTable> {
  $$AwardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AwardsTableOrderingComposer
    extends Composer<_$AppDatabase, $AwardsTable> {
  $$AwardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AwardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AwardsTable> {
  $$AwardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get issuer =>
      $composableBuilder(column: $table.issuer, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$AwardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AwardsTable,
          AwardRow,
          $$AwardsTableFilterComposer,
          $$AwardsTableOrderingComposer,
          $$AwardsTableAnnotationComposer,
          $$AwardsTableCreateCompanionBuilder,
          $$AwardsTableUpdateCompanionBuilder,
          (AwardRow, BaseReferences<_$AppDatabase, $AwardsTable, AwardRow>),
          AwardRow,
          PrefetchHooks Function()
        > {
  $$AwardsTableTableManager(_$AppDatabase db, $AwardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AwardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AwardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AwardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> issuer = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AwardsCompanion(
                id: id,
                title: title,
                issuer: issuer,
                date: date,
                description: description,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> issuer = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AwardsCompanion.insert(
                id: id,
                title: title,
                issuer: issuer,
                date: date,
                description: description,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AwardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AwardsTable,
      AwardRow,
      $$AwardsTableFilterComposer,
      $$AwardsTableOrderingComposer,
      $$AwardsTableAnnotationComposer,
      $$AwardsTableCreateCompanionBuilder,
      $$AwardsTableUpdateCompanionBuilder,
      (AwardRow, BaseReferences<_$AppDatabase, $AwardsTable, AwardRow>),
      AwardRow,
      PrefetchHooks Function()
    >;
typedef $$CustomSectionsTableCreateCompanionBuilder =
    CustomSectionsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> body,
      Value<int> sortOrder,
      Value<bool> isVisible,
    });
typedef $$CustomSectionsTableUpdateCompanionBuilder =
    CustomSectionsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> body,
      Value<int> sortOrder,
      Value<bool> isVisible,
    });

class $$CustomSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomSectionsTable> {
  $$CustomSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomSectionsTable> {
  $$CustomSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomSectionsTable> {
  $$CustomSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);
}

class $$CustomSectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomSectionsTable,
          CustomSectionRow,
          $$CustomSectionsTableFilterComposer,
          $$CustomSectionsTableOrderingComposer,
          $$CustomSectionsTableAnnotationComposer,
          $$CustomSectionsTableCreateCompanionBuilder,
          $$CustomSectionsTableUpdateCompanionBuilder,
          (
            CustomSectionRow,
            BaseReferences<
              _$AppDatabase,
              $CustomSectionsTable,
              CustomSectionRow
            >,
          ),
          CustomSectionRow,
          PrefetchHooks Function()
        > {
  $$CustomSectionsTableTableManager(
    _$AppDatabase db,
    $CustomSectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
              }) => CustomSectionsCompanion(
                id: id,
                title: title,
                body: body,
                sortOrder: sortOrder,
                isVisible: isVisible,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
              }) => CustomSectionsCompanion.insert(
                id: id,
                title: title,
                body: body,
                sortOrder: sortOrder,
                isVisible: isVisible,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomSectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomSectionsTable,
      CustomSectionRow,
      $$CustomSectionsTableFilterComposer,
      $$CustomSectionsTableOrderingComposer,
      $$CustomSectionsTableAnnotationComposer,
      $$CustomSectionsTableCreateCompanionBuilder,
      $$CustomSectionsTableUpdateCompanionBuilder,
      (
        CustomSectionRow,
        BaseReferences<_$AppDatabase, $CustomSectionsTable, CustomSectionRow>,
      ),
      CustomSectionRow,
      PrefetchHooks Function()
    >;
typedef $$JobDescriptionsTableCreateCompanionBuilder =
    JobDescriptionsCompanion Function({
      Value<int> id,
      Value<String> rawText,
      Value<DateTime?> analyzedAt,
      Value<double?> matchScore,
      Value<String> matchedJson,
      Value<String> missingJson,
    });
typedef $$JobDescriptionsTableUpdateCompanionBuilder =
    JobDescriptionsCompanion Function({
      Value<int> id,
      Value<String> rawText,
      Value<DateTime?> analyzedAt,
      Value<double?> matchScore,
      Value<String> matchedJson,
      Value<String> missingJson,
    });

class $$JobDescriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $JobDescriptionsTable> {
  $$JobDescriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get matchScore => $composableBuilder(
    column: $table.matchScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchedJson => $composableBuilder(
    column: $table.matchedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get missingJson => $composableBuilder(
    column: $table.missingJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JobDescriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $JobDescriptionsTable> {
  $$JobDescriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get matchScore => $composableBuilder(
    column: $table.matchScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchedJson => $composableBuilder(
    column: $table.matchedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get missingJson => $composableBuilder(
    column: $table.missingJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobDescriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobDescriptionsTable> {
  $$JobDescriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get matchScore => $composableBuilder(
    column: $table.matchScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchedJson => $composableBuilder(
    column: $table.matchedJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get missingJson => $composableBuilder(
    column: $table.missingJson,
    builder: (column) => column,
  );
}

class $$JobDescriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobDescriptionsTable,
          JobDescriptionRow,
          $$JobDescriptionsTableFilterComposer,
          $$JobDescriptionsTableOrderingComposer,
          $$JobDescriptionsTableAnnotationComposer,
          $$JobDescriptionsTableCreateCompanionBuilder,
          $$JobDescriptionsTableUpdateCompanionBuilder,
          (
            JobDescriptionRow,
            BaseReferences<
              _$AppDatabase,
              $JobDescriptionsTable,
              JobDescriptionRow
            >,
          ),
          JobDescriptionRow,
          PrefetchHooks Function()
        > {
  $$JobDescriptionsTableTableManager(
    _$AppDatabase db,
    $JobDescriptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobDescriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobDescriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobDescriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<DateTime?> analyzedAt = const Value.absent(),
                Value<double?> matchScore = const Value.absent(),
                Value<String> matchedJson = const Value.absent(),
                Value<String> missingJson = const Value.absent(),
              }) => JobDescriptionsCompanion(
                id: id,
                rawText: rawText,
                analyzedAt: analyzedAt,
                matchScore: matchScore,
                matchedJson: matchedJson,
                missingJson: missingJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<DateTime?> analyzedAt = const Value.absent(),
                Value<double?> matchScore = const Value.absent(),
                Value<String> matchedJson = const Value.absent(),
                Value<String> missingJson = const Value.absent(),
              }) => JobDescriptionsCompanion.insert(
                id: id,
                rawText: rawText,
                analyzedAt: analyzedAt,
                matchScore: matchScore,
                matchedJson: matchedJson,
                missingJson: missingJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JobDescriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobDescriptionsTable,
      JobDescriptionRow,
      $$JobDescriptionsTableFilterComposer,
      $$JobDescriptionsTableOrderingComposer,
      $$JobDescriptionsTableAnnotationComposer,
      $$JobDescriptionsTableCreateCompanionBuilder,
      $$JobDescriptionsTableUpdateCompanionBuilder,
      (
        JobDescriptionRow,
        BaseReferences<_$AppDatabase, $JobDescriptionsTable, JobDescriptionRow>,
      ),
      JobDescriptionRow,
      PrefetchHooks Function()
    >;
typedef $$ResumeSettingsTableTableCreateCompanionBuilder =
    ResumeSettingsTableCompanion Function({
      Value<int> id,
      Value<String> templateId,
      Value<int> accentColor,
      Value<String> fontFamily,
      Value<double> fontSize,
      Value<double> margin,
      Value<String> sectionOrderJson,
      Value<String> sectionVisibilityJson,
      Value<bool> hasSeenOnboarding,
    });
typedef $$ResumeSettingsTableTableUpdateCompanionBuilder =
    ResumeSettingsTableCompanion Function({
      Value<int> id,
      Value<String> templateId,
      Value<int> accentColor,
      Value<String> fontFamily,
      Value<double> fontSize,
      Value<double> margin,
      Value<String> sectionOrderJson,
      Value<String> sectionVisibilityJson,
      Value<bool> hasSeenOnboarding,
    });

class $$ResumeSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResumeSettingsTableTable> {
  $$ResumeSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get margin => $composableBuilder(
    column: $table.margin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sectionOrderJson => $composableBuilder(
    column: $table.sectionOrderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sectionVisibilityJson => $composableBuilder(
    column: $table.sectionVisibilityJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSeenOnboarding => $composableBuilder(
    column: $table.hasSeenOnboarding,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResumeSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResumeSettingsTableTable> {
  $$ResumeSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get margin => $composableBuilder(
    column: $table.margin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sectionOrderJson => $composableBuilder(
    column: $table.sectionOrderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sectionVisibilityJson => $composableBuilder(
    column: $table.sectionVisibilityJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSeenOnboarding => $composableBuilder(
    column: $table.hasSeenOnboarding,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResumeSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResumeSettingsTableTable> {
  $$ResumeSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);

  GeneratedColumn<double> get margin =>
      $composableBuilder(column: $table.margin, builder: (column) => column);

  GeneratedColumn<String> get sectionOrderJson => $composableBuilder(
    column: $table.sectionOrderJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sectionVisibilityJson => $composableBuilder(
    column: $table.sectionVisibilityJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasSeenOnboarding => $composableBuilder(
    column: $table.hasSeenOnboarding,
    builder: (column) => column,
  );
}

class $$ResumeSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResumeSettingsTableTable,
          ResumeSettingsRow,
          $$ResumeSettingsTableTableFilterComposer,
          $$ResumeSettingsTableTableOrderingComposer,
          $$ResumeSettingsTableTableAnnotationComposer,
          $$ResumeSettingsTableTableCreateCompanionBuilder,
          $$ResumeSettingsTableTableUpdateCompanionBuilder,
          (
            ResumeSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $ResumeSettingsTableTable,
              ResumeSettingsRow
            >,
          ),
          ResumeSettingsRow,
          PrefetchHooks Function()
        > {
  $$ResumeSettingsTableTableTableManager(
    _$AppDatabase db,
    $ResumeSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResumeSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResumeSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ResumeSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> fontSize = const Value.absent(),
                Value<double> margin = const Value.absent(),
                Value<String> sectionOrderJson = const Value.absent(),
                Value<String> sectionVisibilityJson = const Value.absent(),
                Value<bool> hasSeenOnboarding = const Value.absent(),
              }) => ResumeSettingsTableCompanion(
                id: id,
                templateId: templateId,
                accentColor: accentColor,
                fontFamily: fontFamily,
                fontSize: fontSize,
                margin: margin,
                sectionOrderJson: sectionOrderJson,
                sectionVisibilityJson: sectionVisibilityJson,
                hasSeenOnboarding: hasSeenOnboarding,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> fontSize = const Value.absent(),
                Value<double> margin = const Value.absent(),
                Value<String> sectionOrderJson = const Value.absent(),
                Value<String> sectionVisibilityJson = const Value.absent(),
                Value<bool> hasSeenOnboarding = const Value.absent(),
              }) => ResumeSettingsTableCompanion.insert(
                id: id,
                templateId: templateId,
                accentColor: accentColor,
                fontFamily: fontFamily,
                fontSize: fontSize,
                margin: margin,
                sectionOrderJson: sectionOrderJson,
                sectionVisibilityJson: sectionVisibilityJson,
                hasSeenOnboarding: hasSeenOnboarding,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResumeSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResumeSettingsTableTable,
      ResumeSettingsRow,
      $$ResumeSettingsTableTableFilterComposer,
      $$ResumeSettingsTableTableOrderingComposer,
      $$ResumeSettingsTableTableAnnotationComposer,
      $$ResumeSettingsTableTableCreateCompanionBuilder,
      $$ResumeSettingsTableTableUpdateCompanionBuilder,
      (
        ResumeSettingsRow,
        BaseReferences<
          _$AppDatabase,
          $ResumeSettingsTableTable,
          ResumeSettingsRow
        >,
      ),
      ResumeSettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonalInfoTableTableTableManager get personalInfoTable =>
      $$PersonalInfoTableTableTableManager(_db, _db.personalInfoTable);
  $$SummaryTableTableTableManager get summaryTable =>
      $$SummaryTableTableTableManager(_db, _db.summaryTable);
  $$ExperiencesTableTableManager get experiences =>
      $$ExperiencesTableTableManager(_db, _db.experiences);
  $$EducationsTableTableManager get educations =>
      $$EducationsTableTableManager(_db, _db.educations);
  $$SkillGroupsTableTableManager get skillGroups =>
      $$SkillGroupsTableTableManager(_db, _db.skillGroups);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db, _db.skills);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db, _db.languages);
  $$AwardsTableTableManager get awards =>
      $$AwardsTableTableManager(_db, _db.awards);
  $$CustomSectionsTableTableManager get customSections =>
      $$CustomSectionsTableTableManager(_db, _db.customSections);
  $$JobDescriptionsTableTableManager get jobDescriptions =>
      $$JobDescriptionsTableTableManager(_db, _db.jobDescriptions);
  $$ResumeSettingsTableTableTableManager get resumeSettingsTable =>
      $$ResumeSettingsTableTableTableManager(_db, _db.resumeSettingsTable);
}
