import 'package:pdf/widgets.dart' as pw;

import '../../export/domain/models/resume_settings.dart';
import '../../profile/domain/models/resume_data.dart';

abstract class ResumeTemplate {
  String get id;
  String get name;

  Future<pw.Document> build(ResumeData data, TemplateStyle style);
}
