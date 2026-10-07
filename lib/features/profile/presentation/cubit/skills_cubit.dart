import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_logger.dart';

import '../../domain/models/profile_models.dart';
import '../../domain/repositories/resume_repository.dart';

class SkillsCubit extends Cubit<List<SkillGroup>> {
  SkillsCubit(this._repository) : super(const []);

  final ResumeRepository _repository;
  StreamSubscription<List<SkillGroup>>? _sub;
  Skill? _removedSkill;
  SkillGroup? _removedGroup;

  void start() {
    _sub = listenLogged(
      _repository.watchSkillGroups(),
      (items) => emit(items),
      name: 'SkillsCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<int> ensureGroup() async {
    if (state.isNotEmpty) return state.first.id;
    return _repository.addSkillGroup('Skills');
  }

  Future<void> addGroup(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    await _repository.addSkillGroup(trimmed);
  }

  Future<void> renameGroup(int id, String name) {
    return _repository.renameSkillGroup(id, name.trim());
  }

  Future<void> addSkill(int groupId, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    await _repository.addSkill(groupId, trimmed);
  }

  Future<void> moveSkill(Skill skill, int groupId) async {
    if (skill.groupId == groupId) return;
    final target = state.where((group) => group.id == groupId);
    if (target.isEmpty) return;
    final alreadyHas = target.first.skills.any(
      (item) => item.name.toLowerCase() == skill.name.toLowerCase(),
    );
    if (alreadyHas) return;
    await _repository.moveSkill(skill.id, groupId);
  }

  Future<void> removeSkill(Skill skill) async {
    _removedSkill = skill;
    await _repository.deleteSkill(skill.id);
  }

  Future<void> undoSkill() async {
    final skill = _removedSkill;
    if (skill == null) return;
    _removedSkill = null;
    await _repository.addSkill(skill.groupId, skill.name);
  }

  Future<void> removeGroup(SkillGroup group) async {
    _removedGroup = group;
    await _repository.deleteSkillGroup(group.id);
  }

  Future<void> undoGroup() async {
    final group = _removedGroup;
    if (group == null) return;
    _removedGroup = null;
    final id = await _repository.addSkillGroup(group.name);
    for (final skill in group.skills) {
      await _repository.addSkill(id, skill.name);
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
