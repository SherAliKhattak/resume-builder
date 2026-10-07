import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class ProjectsCubit extends Cubit<List<Project>> {
  ProjectsCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Project>>? _sub;
  Project? _removed;

  void start() {
    _sub = listenLogged(
      _repository.watchProjects(),
      (items) => emit(items),
      name: 'ProjectsCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> save(Project item) async {
    if (item.id == 0) {
      await _repository.addProject(item);
    } else {
      await _repository.updateProject(item);
    }
  }

  Future<void> remove(Project item) async {
    _removed = item;
    await _repository.deleteProject(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addProject(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderProjects([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
