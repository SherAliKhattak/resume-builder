import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/section_keys.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_logger.dart';
import '../../../../core/import/resume_import_service.dart';
import '../../domain/models/resume_data.dart';
import '../../domain/repositories/resume_repository.dart';

class SectionStatus {
  const SectionStatus({
    required this.key,
    required this.complete,
    required this.hidden,
  });

  final String key;
  final bool complete;
  final bool hidden;
}

class ProfileOverviewState {
  const ProfileOverviewState({
    this.sections = const [],
    this.fullName = '',
    this.message,
  });

  final List<SectionStatus> sections;
  final String fullName;
  final String? message;

  ProfileOverviewState copyWith({
    List<SectionStatus>? sections,
    String? fullName,
    String? message,
    bool clearMessage = false,
  }) {
    return ProfileOverviewState(
      sections: sections ?? this.sections,
      fullName: fullName ?? this.fullName,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}

class ProfileOverviewCubit extends Cubit<ProfileOverviewState> {
  ProfileOverviewCubit(this._repository, this._import)
    : super(const ProfileOverviewState());

  final ResumeRepository _repository;
  final ResumeImportService _import;
  StreamSubscription<ResumeData>? _sub;
  var _importing = false;

  void start() {
    _sub = listenLogged(
      _repository.watchResume(),
      (data) => emit(
        state.copyWith(
          sections: _statusFor(data),
          fullName: data.personal.fullName,
          clearMessage: false,
        ),
      ),
      name: 'ProfileOverviewCubit.watch',
      isClosed: () => isClosed,
    );
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
      logAppError('ProfileOverviewCubit.import', error, stack);
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

  List<SectionStatus> _statusFor(ResumeData data) {
    final order = data.settings.sectionOrder.isEmpty
        ? SectionKeys.defaultOrder
        : data.settings.sectionOrder;
    bool complete(String key) {
      switch (key) {
        case SectionKeys.personal:
          return data.personal.isComplete;
        case SectionKeys.summary:
          return data.summary.trim().isNotEmpty;
        case SectionKeys.experience:
          return data.experiences.isNotEmpty;
        case SectionKeys.education:
          return data.educations.isNotEmpty;
        case SectionKeys.skills:
          return data.skillGroups.any((g) => g.skills.isNotEmpty);
        case SectionKeys.courses:
          return data.courses.isNotEmpty;
        case SectionKeys.projects:
          return data.projects.isNotEmpty;
        case SectionKeys.languages:
          return data.languages.isNotEmpty;
        case SectionKeys.awards:
          return data.awards.isNotEmpty;
        case SectionKeys.custom:
          return data.customSections.isNotEmpty;
        default:
          return false;
      }
    }

    return [
      for (final key in order)
        SectionStatus(
          key: key,
          complete: complete(key),
          hidden: !data.settings.isSectionVisible(key),
        ),
    ];
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
