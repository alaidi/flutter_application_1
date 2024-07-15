import 'dart:io';
import 'package:employee_app/config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FileService {
  final Config _config = Config();
  late final Directory appDir;

  // FileService() {
  //   _loadConfig();
  // }

  // void _loadConfig() {
  //   appDir = Directory.current;
  // }

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
    final employeePdfDir =
        Directory(path.join(_config.pdfDir.path, employeeId.toString()));

    if (!await employeePdfDir.exists()) {
      await employeePdfDir.create(recursive: true);
    }

    final savedFile = await file.copy(path.join(employeePdfDir.path, fileName));
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
