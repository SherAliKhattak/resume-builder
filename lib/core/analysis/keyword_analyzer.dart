import '../../features/job_description/domain/models/analyzed_keyword.dart';
import '../../features/job_description/domain/usecases/analyze_job_keywords.dart';
import '../../features/profile/domain/models/resume_data.dart';
import 'skill_lexicon.dart';

export '../../features/job_description/domain/models/analyzed_keyword.dart';

class KeywordAnalyzer {
  KeywordAnalyzer({SkillLexicon? lexicon, Set<String>? dictionary})
    : _useCase = AnalyzeJobKeywords(
        lexicon ??
            (dictionary == null
                ? SkillLexicon.standard()
                : SkillLexicon([
                    ...kSkillEntries,
                    for (final skill in dictionary)
                      SkillEntry(
                        term: skill,
                        category: KeywordCategory.hardSkill,
                      ),
                  ])),
      );

  final AnalyzeJobKeywords _useCase;

  KeywordAnalysis analyze({
    required String jobDescription,
    required ResumeData resume,
  }) {
    return _useCase(jobDescription: jobDescription, resume: resume);
  }
}
