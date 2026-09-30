import 'resume_template.dart';
import '../pdf/templates.dart';

class TemplateRegistry {
  TemplateRegistry(this._templates);

  factory TemplateRegistry.standard() {
    return TemplateRegistry([
      ClassicTemplate(),
      ModernTemplate(),
      MinimalTemplate(),
      ExecutiveTemplate(),
      CreativeTemplate(),
      CompactTemplate(),
      TechTemplate(),
      TimelineTemplate(),
      ElegantTemplate(),
      AtsPlainTemplate(),
    ]);
  }

  final List<ResumeTemplate> _templates;

  List<ResumeTemplate> get all => List.unmodifiable(_templates);

  ResumeTemplate byId(String id) {
    return _templates.firstWhere(
      (template) => template.id == id,
      orElse: () => _templates.first,
    );
  }
}
