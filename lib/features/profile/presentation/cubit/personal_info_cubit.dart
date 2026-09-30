import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../core/utils/lifecycle_flush.dart';
import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class PersonalInfoState {
  const PersonalInfoState({
    this.info = const PersonalInfo(),
    this.saved = false,
    this.nameError,
    this.emailError,
  });

  final PersonalInfo info;
  final bool saved;
  final String? nameError;
  final String? emailError;

  PersonalInfoState copyWith({
    PersonalInfo? info,
    bool? saved,
    String? nameError,
    String? emailError,
    bool clearNameError = false,
    bool clearEmailError = false,
  }) {
    return PersonalInfoState(
      info: info ?? this.info,
      saved: saved ?? this.saved,
      nameError: clearNameError ? null : (nameError ?? this.nameError),
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
    );
  }
}

class PersonalInfoCubit extends Cubit<PersonalInfoState> with LifecycleFlush {
  PersonalInfoCubit(this._repository) : super(const PersonalInfoState());

  final ResumeRepository _repository;
  final _debounce = Debouncer();
  StreamSubscription<PersonalInfo>? _sub;
  Timer? _savedTimer;
  bool _applyingRemote = false;

  void start() {
    attachLifecycleFlush();
    _sub = _repository.watchPersonalInfo().listen((info) {
      if (isClosed) return;
      _applyingRemote = true;
      emit(state.copyWith(info: info));
      _applyingRemote = false;
    });
  }

  void onChanged(PersonalInfo info) {
    final nameError = info.fullName.trim().isEmpty
        ? 'Please add your name.'
        : null;
    final emailError = _emailError(info.email);
    emit(
      state.copyWith(
        info: info,
        nameError: nameError,
        emailError: emailError,
        clearNameError: nameError == null,
        clearEmailError: emailError == null,
      ),
    );
    if (_applyingRemote) return;
    _debounce(() => _save(info));
  }

  String? _emailError(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return 'Please add your email.';
    if (!trimmed.contains('@') || !trimmed.contains('.')) {
      return 'That email does not look right.';
    }
    return null;
  }

  Future<void> _save(PersonalInfo info) async {
    await _repository.savePersonalInfo(info);
    emit(state.copyWith(saved: true));
    _savedTimer?.cancel();
    _savedTimer = Timer(AppDurations.saved, () {
      if (!isClosed) emit(state.copyWith(saved: false));
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
