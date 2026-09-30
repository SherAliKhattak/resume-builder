import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class AwardsCubit extends Cubit<List<Award>> {
  AwardsCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Award>>? _sub;
  Award? _removed;

  void start() {
    _sub = _repository.watchAwards().listen((items) {
      if (!isClosed) emit(items);
    });
  }

  Future<void> save(Award item) async {
    if (item.id == 0) {
      await _repository.addAward(item);
    } else {
      await _repository.updateAward(item);
    }
  }

  Future<void> remove(Award item) async {
    _removed = item;
    await _repository.deleteAward(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addAward(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderAwards([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
