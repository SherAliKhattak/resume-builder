import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/section_keys.dart';
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
    this.busy = false,
    this.message,
  });

  final List<SectionStatus> sections;
  final bool busy;
  final String? message;

  ProfileOverviewState copyWith({
    List<SectionStatus>? sections,
    bool? busy,
    String? message,
    bool clearMessage = false,
  }) {
    return ProfileOverviewState(
      sections: sections ?? this.sections,
      busy: busy ?? this.busy,
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

  void start() {
    _sub = _repository.watchResume().listen((data) {
      if (!isClosed) {
        emit(state.copyWith(sections: _statusFor(data), clearMessage: false));
      }
    });
  }

  Future<void> importResume() async {
    emit(state.copyWith(busy: true, clearMessage: true));
    try {
      final result = await _import.importFromPicker();
      if (isClosed) return;
      emit(
        state.copyWith(
          busy: false,
          message: result.cancelled ? null : result.message,
          clearMessage: result.cancelled,
        ),
      );
    } catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          busy: false,
          message: 'Could not read that file. Try a PDF, Word, or text resume.',
        ),
      );
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
