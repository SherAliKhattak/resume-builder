import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/features/export/domain/models/resume_settings.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';
import 'package:resume_builder/features/templates/domain/template_registry.dart';
import 'package:resume_builder/features/templates/pdf/pdf_safe.dart';
import 'package:resume_builder/features/templates/pdf/templates.dart';
import 'package:resume_builder/seed/sample_resume.dart';

void main() {
  const style = TemplateStyle(accentColor: 0xFF1D4ED8);

  test('unicode text still builds a PDF', () async {
    final data = SampleResume.data.copyWith(
      summary: 'Owned “checkout” — cut load time by 40% • shipped it.',
    );
    final doc = await ClassicTemplate().build(
      pdfSafeResume(data),
      style,
    );
    final bytes = await doc.save();
    expect(bytes, isNotEmpty);
  });

  test('all 10 templates build a multi-page PDF', () async {
    final registry = TemplateRegistry.standard();
    expect(registry.all, hasLength(10));
    for (final template in registry.all) {
      final doc = await template.build(SampleResume.data, style);
      final bytes = await doc.save();
      expect(bytes, isNotEmpty, reason: template.id);
    }
  });

  test('modern and executive split a long resume instead of hanging', () async {
    final long = SampleResume.data.copyWith(
      experiences: [
        for (var i = 0; i < 6; i++)
          Experience(
            role: 'Engineer $i',
            company: 'Northwind Labs',
            startDate: '2020',
            endDate: '2021',
            bullets: [
              for (var n = 0; n < 8; n++)
                'Shipped a measurable improvement that helped customers finish work faster.',
            ],
          ),
      ],
    );
    for (final template in [ModernTemplate(), ExecutiveTemplate()]) {
      final doc = await template.build(long, style);
      final bytes = await doc.save().timeout(const Duration(seconds: 6));
      expect(bytes, isNotEmpty, reason: template.id);
    }
  });
}
