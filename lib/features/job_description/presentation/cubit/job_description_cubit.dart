import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_logger.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../domain/ats_reviewer.dart';
import '../../domain/models/job_description.dart';

class JobDescriptionState {
  const JobDescriptionState({
    this.rawText = '',
    this.busy = false,
    this.ready = false,
    this.aiReview,
    this.aiError,
    this.message,
  });

  final String rawText;
  final bool busy;
  final bool ready;
  final AtsReview? aiReview;
  final String? aiError;
  final String? message;

  JobDescriptionState copyWith({
    String? rawText,
    bool? busy,
    bool? ready,
    AtsReview? aiReview,
    String? aiError,
    String? message,
    bool clearAiReview = false,
    bool clearAiError = false,
    bool clearMessage = false,
  }) {
    return JobDescriptionState(
      rawText: rawText ?? this.rawText,
      busy: busy ?? this.busy,
      ready: ready ?? this.ready,
      aiReview: clearAiReview ? null : (aiReview ?? this.aiReview),
      aiError: clearAiError ? null : (aiError ?? this.aiError),
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}

class JobDescriptionCubit extends Cubit<JobDescriptionState>
    with LifecycleFlush {
  JobDescriptionCubit(this._repository, {AtsReviewer? reviewer})
    : _reviewer = reviewer ?? const NoOpAtsReviewer(),
      super(const JobDescriptionState());

  final ResumeRepository _repository;
  final AtsReviewer _reviewer;
  StreamSubscription<JobDescription>? _sub;
  StreamSubscription<ResumeData>? _resumeSub;
  Future<void> _writes = Future.value();
  bool _applyingRemote = false;
  bool _analyzing = false;
  String? _profileFingerprint;
  Timer? _refreshDebounce;

  void start() {
    attachLifecycleFlush();
    unawaited(_start());
  }

  Future<void> _start() async {
    try {
      _profileFingerprint = (await _repository.getResume()).allText;
      if (isClosed) return;
      _sub = listenLogged(
        _repository.watchJobDescription(),
        (job) {
          _applyingRemote = true;
          emit(state.copyWith(rawText: job.rawText, ready: true));
          _applyingRemote = false;
        },
        name: 'JobDescriptionCubit.watchJob',
        isClosed: () => isClosed,
      );
      _resumeSub = listenLogged(
        _repository.watchResume(),
        _onResumeChanged,
        name: 'JobDescriptionCubit.watchResume',
        isClosed: () => isClosed,
      );
    } catch (error, stack) {
      logAppError('JobDescriptionCubit.start', error, stack);
      if (!isClosed) {
        final friendly = userFacingMessage(
          error,
          fallback: 'Could not load this job post.',
        );
        emit(
          state.copyWith(
            ready: true,
            aiError: friendly,
            message: friendly,
          ),
        );
      }
    }
  }

  void _onResumeChanged(ResumeData resume) {
    final fingerprint = resume.allText;
    if (fingerprint == _profileFingerprint) return;
    _profileFingerprint = fingerprint;
    _queueAnalysisRefresh();
  }

  void _queueAnalysisRefresh() {
    if (state.rawText.trim().isEmpty) return;
    _refreshDebounce?.cancel();
    _refreshDebounce = Timer(const Duration(milliseconds: 250), () {
      if (!isClosed) unawaited(analyze(reorder: false));
    });
  }

  void onChanged(String text) {
    emit(
      state.copyWith(
        rawText: text,
        clearAiReview: true,
        clearAiError: true,
        clearMessage: true,
      ),
    );
    if (_applyingRemote) return;
    _writes = _writes.then((_) async {
      try {
        if (isClosed) return;
        await _repository.saveJobDescription(JobDescription(rawText: text));
      } catch (error, stack) {
        logAppError('JobDescriptionCubit.save', error, stack);
      }
    });
  }

  @override
  Future<void> flushPending() => _writes;

  Future<void> analyze({bool reorder = true}) async {
    if (_analyzing) return;
    await flushPending();
    final text = state.rawText.trim();
    if (text.isEmpty) return;
    _analyzing = true;
    emit(state.copyWith(busy: true, clearAiError: true, clearMessage: true));
    try {
      final resume = await _repository.getResume();
      _profileFingerprint = resume.allText;
      final review = await _reviewer.review(
        jobDescription: text,
        resumeText: resume.allText,
      );
      if (review == null) {
        throw Exception('Received an empty review.');
      }
      await _repository.saveJobDescription(
        JobDescription(
          rawText: text,
          analyzedAt: DateTime.now(),
          matchScore: review.score.toDouble(),
          matched: review.matchedKeywords,
          missing: review.missingKeywords,
        ),
      );
      if (reorder) {
        await _reorderByRelevance(resume, [
          ...review.matchedKeywords,
          ...review.missingKeywords,
        ]);
      }
      if (isClosed) return;
      emit(state.copyWith(busy: false, aiReview: review));
    } catch (error, stack) {
      logAppError('JobDescriptionCubit.analyze', error, stack);
      if (!isClosed) {
        final friendly = userFacingMessage(
          error,
          fallback: 'Please wait a moment and try again.',
        );
        emit(
          state.copyWith(
            busy: false,
            aiError: friendly,
            message: friendly,
          ),
        );
      }
    } finally {
      _analyzing = false;
    }
  }

  Future<void> requestAiReview() => analyze(reorder: false);

  Future<void> addSuggestedSkill(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    try {
      final resume = await _repository.getResume();
      final alreadyHas = resume.skillGroups.any(
        (group) => group.skills.any(
          (skill) => skill.name.toLowerCase() == trimmed.toLowerCase(),
        ),
      );
      if (alreadyHas) {
        if (!isClosed) {
          emit(state.copyWith(message: '$trimmed is already a skill.'));
        }
        return;
      }
      final groupId = resume.skillGroups.isEmpty
          ? await _repository.addSkillGroup('Skills')
          : resume.skillGroups.first.id;
      await _repository.addSkill(groupId, trimmed);
      if (!isClosed) emit(state.copyWith(message: 'Added $trimmed to Skills.'));
    } catch (error, stack) {
      logAppError('JobDescriptionCubit.addSkill', error, stack);
      if (!isClosed) {
        emit(state.copyWith(message: 'Could not add $trimmed. Try again.'));
      }
    }
  }

  Future<void> applySuggestedSummary() async {
    final summary = state.aiReview?.profileSummary?.trim();
    if (summary == null || summary.isEmpty) return;
    try {
      await _repository.saveSummary(summary);
      if (!isClosed) emit(state.copyWith(message: 'Summary updated.'));
    } catch (error, stack) {
      logAppError('JobDescriptionCubit.summary', error, stack);
      if (!isClosed) {
        emit(state.copyWith(message: 'Could not update the summary. Try again.'));
      }
    }
  }

  void clearMessage() {
    if (state.message != null) emit(state.copyWith(clearMessage: true));
  }

  Future<void> _reorderByRelevance(
    ResumeData resume,
    List<String> keywords,
  ) async {
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
    _refreshDebounce?.cancel();
    await flushPending();
    await _sub?.cancel();
    await _resumeSub?.cancel();
    return super.close();
  }
}
