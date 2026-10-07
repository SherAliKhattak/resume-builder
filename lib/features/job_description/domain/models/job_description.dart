import '../../../../core/utils/json_list.dart';

export 'analyzed_keyword.dart';
export 'ats_review.dart';

class JobDescription {
  const JobDescription({
    this.id = 0,
    this.rawText = '',
    this.analyzedAt,
    this.matchScore,
    this.matched = const [],
    this.missing = const [],
  });

  final int id;
  final String rawText;
  final DateTime? analyzedAt;
  final double? matchScore;
  final List<String> matched;
  final List<String> missing;

  bool get hasAnalysis => analyzedAt != null && matchScore != null;

  JobDescription copyWith({
    int? id,
    String? rawText,
    DateTime? analyzedAt,
    double? matchScore,
    List<String>? matched,
    List<String>? missing,
    bool clearAnalysis = false,
  }) {
    return JobDescription(
      id: id ?? this.id,
      rawText: rawText ?? this.rawText,
      analyzedAt: clearAnalysis ? null : (analyzedAt ?? this.analyzedAt),
      matchScore: clearAnalysis ? null : (matchScore ?? this.matchScore),
      matched: matched ?? this.matched,
      missing: missing ?? this.missing,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'rawText': rawText,
    'analyzedAt': analyzedAt?.toIso8601String(),
    'matchScore': matchScore,
    'matched': matched,
    'missing': missing,
  };

  factory JobDescription.fromJson(Map<String, dynamic> json) {
    final analyzed = json['analyzedAt'];
    return JobDescription(
      id: readInt(json, 'id'),
      rawText: readString(json, 'rawText'),
      analyzedAt: analyzed is String ? DateTime.tryParse(analyzed) : null,
      matchScore: json['matchScore'] == null
          ? null
          : readDouble(json, 'matchScore'),
      matched: stringListFromJson(json['matched']),
      missing: stringListFromJson(json['missing']),
    );
  }
}
