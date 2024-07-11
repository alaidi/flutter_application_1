import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FileService {
  late final Directory appDir;

  FileService() {
    _loadConfig();
  }

  void _loadConfig() {
    appDir = Directory.current;
  }

  Future<String?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  Future<String> saveFile(String filePath, int employeeId) async {
    final file = File(filePath);
    final fileName = '${employeeId}_${const Uuid().v4()}.pdf';
    final pdfDir =
        Directory(path.join(appDir.path, 'pdf', employeeId.toString()));

    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    final savedFile = await file.copy(path.join(pdfDir.path, fileName));
    return savedFile.path;
  }

  Future<void> deleteFile(String? filePath) async {
    if (filePath != null && filePath.isNotEmpty) {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
