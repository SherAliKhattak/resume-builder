import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../domain/repositories/resume_repository.dart';

class SummaryState {
  const SummaryState({this.body = '', this.saved = false});

  final String body;
  final bool saved;

  SummaryState copyWith({String? body, bool? saved}) {
    return SummaryState(body: body ?? this.body, saved: saved ?? this.saved);
  }
}

class SummaryCubit extends Cubit<SummaryState> with LifecycleFlush {
  SummaryCubit(this._repository) : super(const SummaryState());

  final ResumeRepository _repository;
  final _debounce = Debouncer();
  StreamSubscription<String>? _sub;
  Timer? _savedTimer;
  bool _applyingRemote = false;

  void start() {
    attachLifecycleFlush();
    _sub = _repository.watchSummary().listen((body) {
      if (isClosed) return;
      _applyingRemote = true;
      emit(state.copyWith(body: body));
      _applyingRemote = false;
    });
  }

  void onChanged(String body) {
    emit(state.copyWith(body: body));
    if (_applyingRemote) return;
    _debounce(() async {
      await _repository.saveSummary(body);
      emit(state.copyWith(saved: true));
      _savedTimer?.cancel();
      _savedTimer = Timer(AppDurations.saved, () {
        if (!isClosed) emit(state.copyWith(saved: false));
      });
    });
  }

  @override
  Future<void> flushPending() => _debounce.flush();

  @override
  Future<void> close() async {
    detachLifecycleFlush();
    await flushPending();
    await _sub?.cancel();
    _savedTimer?.cancel();
    return super.close();
  }
}
