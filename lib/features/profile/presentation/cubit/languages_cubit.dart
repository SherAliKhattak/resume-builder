import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class LanguagesCubit extends Cubit<List<Language>> {
  LanguagesCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<Language>>? _sub;
  Language? _removed;

  void start() {
    _sub = listenLogged(
      _repository.watchLanguages(),
      (items) => emit(items),
      name: 'LanguagesCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<void> save(Language item) async {
    if (item.id == 0) {
      await _repository.addLanguage(item);
    } else {
      await _repository.updateLanguage(item);
    }
  }

  Future<void> remove(Language item) async {
    _removed = item;
    await _repository.deleteLanguage(item.id);
  }

  Future<void> undoRemove() async {
    final item = _removed;
    if (item == null) return;
    _removed = null;
    await _repository.addLanguage(item.copyWith(id: 0));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(items);
    await _repository.reorderLanguages([for (final e in items) e.id]);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
