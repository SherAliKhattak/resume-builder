enum ResumeFont {
  inter,
  libreBaskerville,
  sourceCodePro;

  String get id => name;

  String get label => switch (this) {
    ResumeFont.inter => 'Inter',
    ResumeFont.libreBaskerville => 'Libre Baskerville',
    ResumeFont.sourceCodePro => 'Source Code Pro',
  };

  String get flutterFamily => switch (this) {
    ResumeFont.inter => 'Inter',
    ResumeFont.libreBaskerville => 'Libre Baskerville',
    ResumeFont.sourceCodePro => 'Source Code Pro',
  };

  static const defaultFont = ResumeFont.inter;

  static ResumeFont fromId(String? id) {
    return ResumeFont.values.firstWhere(
      (font) => font.id == id,
      orElse: () => defaultFont,
    );
  }
}
