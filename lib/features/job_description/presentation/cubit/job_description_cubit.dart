import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/analysis/keyword_analyzer.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../domain/models/job_description.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../profile/domain/repositories/resume_repository.dart';

class JobDescriptionState {
  const JobDescriptionState({
    this.rawText = '',
    this.analysis,
    this.busy = false,
    this.suggestion,
  });

  final String rawText;
  final KeywordAnalysis? analysis;
  final bool busy;
  final String? suggestion;

  JobDescriptionState copyWith({
    String? rawText,
    KeywordAnalysis? analysis,
    bool? busy,
    String? suggestion,
    bool clearAnalysis = false,
  }) {
    return JobDescriptionState(
      rawText: rawText ?? this.rawText,
      analysis: clearAnalysis ? null : (analysis ?? this.analysis),
      busy: busy ?? this.busy,
      suggestion: suggestion ?? this.suggestion,
    );
  }
}

class JobDescriptionCubit extends Cubit<JobDescriptionState>
    with LifecycleFlush {
  JobDescriptionCubit(this._repository, this._analyzer)
    : super(const JobDescriptionState());

  final ResumeRepository _repository;
  final KeywordAnalyzer _analyzer;
  StreamSubscription<JobDescription>? _sub;
  Timer? _debounce;
  bool _applyingRemote = false;

  var _dirty = false;

  void start() {
    attachLifecycleFlush();
    _sub = _repository.watchJobDescription().listen((job) {
      if (isClosed) return;
      _applyingRemote = true;
      emit(
        state.copyWith(
          rawText: job.rawText,
          analysis: job.hasAnalysis
              ? KeywordAnalysis(
                  score: job.matchScore ?? 0,
                  matched: job.matched,
                  missing: job.missing,
                )
              : null,
          clearAnalysis: !job.hasAnalysis,
        ),
      );
      _applyingRemote = false;
    });
  }

  void onChanged(String text) {
    emit(state.copyWith(rawText: text, suggestion: null, clearAnalysis: true));
    if (_applyingRemote) return;
    _dirty = true;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _debounce = null;
      _dirty = false;
      _repository.saveJobDescription(JobDescription(rawText: text));
    });
  }

  @override
  Future<void> flushPending() async {
    final shouldSave = _dirty || _debounce != null;
    _debounce?.cancel();
    _debounce = null;
    if (!shouldSave) return;
    _dirty = false;
    await _repository.saveJobDescription(
      JobDescription(
        rawText: state.rawText,
        analyzedAt: state.analysis == null ? null : DateTime.now(),
        matchScore: state.analysis?.score,
        matched: state.analysis?.matched ?? const [],
        missing: state.analysis?.missing ?? const [],
      ),
    );
  }

  Future<void> analyze() async {
    _debounce?.cancel();
    _debounce = null;
    _dirty = false;
    final text = state.rawText.trim();
    if (text.isEmpty) return;
    emit(state.copyWith(busy: true));
    final resume = await _repository.getResume();
    final analysis = _analyzer.analyze(
      jobDescription: text,
      resume: resume,
    );
    await _repository.saveJobDescription(
      JobDescription(
        rawText: text,
        analyzedAt: DateTime.now(),
        matchScore: analysis.score,
        matched: analysis.matched,
        missing: analysis.missing,
      ),
    );
    await _reorderByRelevance(resume, analysis);
    emit(
      state.copyWith(
        busy: false,
        analysis: analysis,
        suggestion: analysis.missing.isEmpty
            ? 'Nice — your details already cover this job post.'
            : 'Skills and projects were reordered by relevance.',
      ),
    );
  }

  Future<void> _reorderByRelevance(
    ResumeData resume,
    KeywordAnalysis analysis,
  ) async {
    final keywords = [...analysis.matched, ...analysis.missing];
    if (keywords.isEmpty) return;

    int score(String text) {
      final lower = text.toLowerCase();
      return keywords.where((k) => lower.contains(k.toLowerCase())).length;
    }

    final groups = [...resume.skillGroups]
      ..sort((a, b) {
        final aScore = a.skills.fold<int>(0, (p, s) => p + score(s.name));
        final bScore = b.skills.fold<int>(0, (p, s) => p + score(s.name));
        return bScore.compareTo(aScore);
      });
    await _repository.reorderSkillGroups([for (final g in groups) g.id]);

    for (final group in groups) {
      final skills = [...group.skills]
        ..sort((a, b) => score(b.name).compareTo(score(a.name)));
      await _repository.reorderSkills([for (final s in skills) s.id]);
    }

    final projects = [...resume.projects]
      ..sort((a, b) {
        final aScore = score('${a.name} ${a.description} ${a.techStack}');
        final bScore = score('${b.name} ${b.description} ${b.techStack}');
        return bScore.compareTo(aScore);
      });
    await _repository.reorderProjects([for (final p in projects) p.id]);
  }

  @override
  Future<void> close() async {
    detachLifecycleFlush();
    await flushPending();
    await _sub?.cancel();
    return super.close();
  }
}
