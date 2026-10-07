import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class CoursesCubit extends Cubit<List<Course>> {
  CoursesCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Course>>? _sub;
  Course? _removed;

  void start() {
    _sub = listenLogged(
      _repository.watchCourses(),
      (items) => emit(items),
      name: 'CoursesCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> save(Course item) async {
    if (item.id == 0) {
      await _repository.addCourse(item);
    } else {
      await _repository.updateCourse(item);
    }
  }

  Future<void> remove(Course item) async {
    _removed = item;
    await _repository.deleteCourse(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addCourse(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderCourses([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
