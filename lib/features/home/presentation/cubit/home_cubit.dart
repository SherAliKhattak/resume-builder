import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_logger.dart';

import '../../../../core/backup/backup_service.dart';
import '../../../../core/import/resume_import_service.dart';
import '../../../profile/domain/models/profile_models.dart';
import '../../../profile/domain/repositories/resume_repository.dart';

class HomeState {
  const HomeState({this.hasStarted = false, this.busy = false, this.message});

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
  var _importing = false;

  void start() {
    _sub = listenLogged(
      _repository.watchPersonalInfo(),
      (info) =>
          emit(state.copyWith(hasStarted: info.fullName.trim().isNotEmpty)),
      name: 'HomeCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> begin({required String name, required String title}) async {
    final info = await _repository.watchPersonalInfo().first;
    final nextName = name.trim().isEmpty ? info.fullName : name.trim();
    await _repository.savePersonalInfo(
      info.copyWith(
        fullName: nextName,
        title: title.trim().isEmpty ? info.title : title.trim(),
      ),
    );
  }

  Future<void> exportBackup() async {
    emit(state.copyWith(busy: true, message: null));
    try {
      await _backup.exportBackup();
      emit(state.copyWith(busy: false, message: 'Backup ready to share.'));
    } catch (error, stack) {
      logAppError('HomeCubit.exportBackup', error, stack);
      emit(
        state.copyWith(
          busy: false,
          message: userFacingMessage(
            error,
            fallback: 'Could not create a backup.',
          ),
        ),
      );
    }
  }

  Future<void> importResume() async {
    if (_importing) return;
    _importing = true;
    try {
      final picked = await _import.pickResume();
      if (picked == null) return;
      if (!isClosed) emit(state.copyWith(message: 'Reading resume…'));
      final result = await _import.importBytes(
        bytes: picked.bytes,
        filename: picked.filename,
      );
      if (!isClosed) emit(state.copyWith(message: result.message));
    } catch (error, stack) {
      logAppError('HomeCubit.importResume', error, stack);
      if (!isClosed) {
        emit(
          state.copyWith(
            message: userFacingMessage(
              error,
              fallback:
                  'Could not read that file. Try a PDF, Word, or text resume.',
            ),
          ),
        );
      }
    } finally {
      _importing = false;
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
    } catch (error, stack) {
      logAppError('HomeCubit.importBackup', error, stack);
      emit(
        state.copyWith(
          busy: false,
          message: userFacingMessage(
            error,
            fallback: 'Could not restore that file.',
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
