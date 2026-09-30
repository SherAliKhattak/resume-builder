import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openConnection() {
  return driftDatabase(name: 'resume_builder');
}

QueryExecutor openInMemoryConnection() {
  return NativeDatabase.memory();
}
