import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class EducationCubit extends Cubit<List<Education>> {
  EducationCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Education>>? _sub;
  Education? _removed;

  void start() {
    _sub = listenLogged(
      _repository.watchEducations(),
      (items) => emit(items),
      name: 'EducationCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> save(Education item) async {
    if (item.id == 0) {
      await _repository.addEducation(item);
    } else {
      await _repository.updateEducation(item);
    }
  }

  Future<void> remove(Education item) async {
    _removed = item;
    await _repository.deleteEducation(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addEducation(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderEducations([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
