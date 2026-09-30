import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/profile/domain/repositories/resume_repository.dart';

class BackupService {
  BackupService(this._repository);

  final ResumeRepository _repository;

  Future<void> exportBackup() async {
    final json = await _repository.exportJson();
    final encoded = const JsonEncoder.withIndent('  ').convert(json);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/resume-backup.json');
    await file.writeAsString(encoded);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        fileNameOverrides: const ['resume-backup.json'],
      ),
    );
  }

  Future<bool> importBackup() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (files.isEmpty) return false;
    final file = files.first;
    final content = utf8.decode(await file.readAsBytes());
    final decoded = jsonDecode(content);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Backup file is not valid.');
    }
    await _repository.importJson(decoded);
    return true;
  }
}
