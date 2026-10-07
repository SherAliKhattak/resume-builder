import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/errors/error_logger.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../domain/repositories/resume_repository.dart';

class SummaryState {
  const SummaryState({this.body = '', this.saved = false, this.ready = false});

  final String body;
  final bool saved;
  final bool ready;

  SummaryState copyWith({String? body, bool? saved, bool? ready}) {
    return SummaryState(
      body: body ?? this.body,
      saved: saved ?? this.saved,
      ready: ready ?? this.ready,
    );
  }
}

class SummaryCubit extends Cubit<SummaryState> with LifecycleFlush {
  SummaryCubit(this._repository) : super(const SummaryState());

  final ResumeRepository _repository;
  Future<void> _writes = Future.value();
  StreamSubscription<String>? _sub;
  Timer? _savedTimer;
  bool _applyingRemote = false;

  void start() {
    attachLifecycleFlush();
    _sub = listenLogged(
      _repository.watchSummary(),
      (body) {
        _applyingRemote = true;
        emit(state.copyWith(body: body, ready: true));
        _applyingRemote = false;
      },
      name: 'SummaryCubit.watch',
      isClosed: () => isClosed,
    );
  }

  void onChanged(String body) {
    emit(state.copyWith(body: body));
    if (_applyingRemote) return;
    _writes = _writes.then((_) async {
      try {
        if (isClosed) return;
        await _repository.saveSummary(body);
        if (isClosed) return;
        emit(state.copyWith(saved: true));
        _savedTimer?.cancel();
        _savedTimer = Timer(AppDurations.saved, () {
          if (!isClosed) emit(state.copyWith(saved: false));
        });
      } catch (error, stack) {
        logAppError('SummaryCubit.save', error, stack);
      }
    });
  }

  @override
  Future<void> flushPending() => _writes;

  @override
  Future<void> close() async {
    detachLifecycleFlush();
    await flushPending();
    await _sub?.cancel();
    _savedTimer?.cancel();
    return super.close();
  }
}
