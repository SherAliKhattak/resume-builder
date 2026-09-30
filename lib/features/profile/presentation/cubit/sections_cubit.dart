import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/section_keys.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../domain/repositories/resume_repository.dart';

class SectionsCubit extends Cubit<ResumeSettings> {
  SectionsCubit(this._repository) : super(const ResumeSettings());

  final ResumeRepository _repository;
  StreamSubscription<ResumeSettings>? _sub;

  void start() {
    _sub = _repository.watchSettings().listen((settings) {
      if (!isClosed) emit(settings);
    });
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final order = [...state.sectionOrder];
    if (order.isEmpty) {
      order.addAll(SectionKeys.defaultOrder);
    }
    if (newIndex > oldIndex) newIndex -= 1;
    final item = order.removeAt(oldIndex);
    order.insert(newIndex, item);
    await _repository.saveSettings(state.copyWith(sectionOrder: order));
  }

  Future<void> toggleVisible(String key, bool visible) async {
    final visibility = Map<String, bool>.from(state.sectionVisibility);
    visibility[key] = visible;
    await _repository.saveSettings(
      state.copyWith(sectionVisibility: visibility),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
