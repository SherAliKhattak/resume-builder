import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class ExperienceCubit extends Cubit<List<Experience>> {
  ExperienceCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Experience>>? _sub;
  Experience? _removed;

  void start() {
    _sub = listenLogged(
      _repository.watchExperiences(),
      (items) => emit(items),
      name: 'ExperienceCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> save(Experience item) async {
    if (item.id == 0) {
      await _repository.addExperience(item);
    } else {
      await _repository.updateExperience(item);
    }
  }

  Future<void> remove(Experience item) async {
    _removed = item;
    await _repository.deleteExperience(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addExperience(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderExperiences([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
