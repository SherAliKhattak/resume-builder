import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class CustomSectionsCubit extends Cubit<List<CustomSection>> {
  CustomSectionsCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<CustomSection>>? _sub;
  CustomSection? _removed;

  void start() {
    _sub = _repository.watchCustomSections().listen((items) {
      if (!isClosed) emit(items);
    });
  }

  Future<void> save(CustomSection item) async {
    if (item.id == 0) {
      await _repository.addCustomSection(item);
    } else {
      await _repository.updateCustomSection(item);
    }
  }

  Future<void> remove(CustomSection item) async {
    _removed = item;
    await _repository.deleteCustomSection(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addCustomSection(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderCustomSections([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
