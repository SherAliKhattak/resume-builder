import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final documents = await getApplicationDocumentsDirectory();
    await documents.create(recursive: true);
    // Keep journals next to the database, never in the OS cache directory.
    sqlite3.tempDirectory = documents.path;
    final file = File('${documents.path}/resume_builder.sqlite');

    return NativeDatabase(
      file,
      setup: (database) {
        database
          ..execute('PRAGMA foreign_keys = ON')
          ..execute('PRAGMA busy_timeout = 5000')
          ..execute('PRAGMA journal_mode = DELETE')
          ..execute('PRAGMA synchronous = FULL');
      },
    );
  });
}

QueryExecutor openInMemoryConnection() {
  return NativeDatabase.memory();
}
