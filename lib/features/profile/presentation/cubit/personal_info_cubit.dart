import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/errors/error_logger.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class PersonalInfoState {
  const PersonalInfoState({
    this.info = const PersonalInfo(),
    this.saved = false,
    this.ready = false,
  });

  final PersonalInfo info;
  final bool saved;
  final bool ready;

  PersonalInfoState copyWith({
    PersonalInfo? info,
    bool? saved,
    bool? ready,
  }) {
    return PersonalInfoState(
      info: info ?? this.info,
      saved: saved ?? this.saved,
      ready: ready ?? this.ready,
    );
  }
}

class PersonalInfoCubit extends Cubit<PersonalInfoState> with LifecycleFlush {
  PersonalInfoCubit(this._repository) : super(const PersonalInfoState());

  final ResumeRepository _repository;
  Future<void> _writes = Future.value();
  StreamSubscription<PersonalInfo>? _sub;
  Timer? _savedTimer;
  bool _applyingRemote = false;

  void start() {
    attachLifecycleFlush();
    _sub = listenLogged(
      _repository.watchPersonalInfo(),
      (info) {
        _applyingRemote = true;
        emit(state.copyWith(info: info, ready: true));
        _applyingRemote = false;
      },
      name: 'PersonalInfoCubit.watch',
      isClosed: () => isClosed,
    );
  }

  void onChanged(PersonalInfo info) {
    emit(state.copyWith(info: info));
    if (_applyingRemote) return;
    _writes = _writes.then((_) async {
      try {
        if (isClosed) return;
        await _save(info);
      } catch (error, stack) {
        logAppError('PersonalInfoCubit.save', error, stack);
      }
    });
  }

  Future<void> _save(PersonalInfo info) async {
    await _repository.savePersonalInfo(info);
    if (isClosed) return;
    emit(state.copyWith(saved: true));
    _savedTimer?.cancel();
    _savedTimer = Timer(AppDurations.saved, () {
      if (!isClosed) emit(state.copyWith(saved: false));
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
