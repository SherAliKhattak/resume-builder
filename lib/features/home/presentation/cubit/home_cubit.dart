import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/backup/backup_service.dart';
import '../../../../core/import/resume_import_service.dart';
import '../../../profile/domain/models/profile_models.dart';
import '../../../profile/domain/repositories/resume_repository.dart';

class HomeState {
  const HomeState({
    this.hasStarted = false,
    this.busy = false,
    this.message,
  });

  final bool hasStarted;
  final bool busy;
  final String? message;

  HomeState copyWith({bool? hasStarted, bool? busy, String? message}) {
    return HomeState(
      hasStarted: hasStarted ?? this.hasStarted,
      busy: busy ?? this.busy,
      message: message,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository, this._backup, this._import)
    : super(const HomeState());

  final ResumeRepository _repository;
  final BackupService _backup;
  final ResumeImportService _import;
  StreamSubscription<PersonalInfo>? _sub;

  void start() {
    _sub = _repository.watchPersonalInfo().listen((info) {
      if (isClosed) return;
      emit(state.copyWith(hasStarted: info.fullName.trim().isNotEmpty));
    });
  }

  Future<void> exportBackup() async {
    emit(state.copyWith(busy: true, message: null));
    try {
      await _backup.exportBackup();
      emit(state.copyWith(busy: false, message: 'Backup ready to share.'));
    } catch (error) {
      emit(state.copyWith(busy: false, message: 'Could not create a backup.'));
    }
  }

  Future<void> importResume() async {
    emit(state.copyWith(busy: true, message: null));
    try {
      final result = await _import.importFromPicker();
      emit(
        state.copyWith(
          busy: false,
          message: result.cancelled ? null : result.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          busy: false,
          message: 'Could not read that file. Try a PDF, Word, or text resume.',
        ),
      );
    }
  }

  Future<void> importBackup() async {
    emit(state.copyWith(busy: true, message: null));
    try {
      final imported = await _backup.importBackup();
      emit(
        state.copyWith(
          busy: false,
          message: imported ? 'Backup restored.' : null,
        ),
      );
    } catch (error) {
      emit(state.copyWith(busy: false, message: 'Could not restore that file.'));
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
