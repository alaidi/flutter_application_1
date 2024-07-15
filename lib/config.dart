import 'dart:io';
import 'package:path/path.dart' as path;

class Config {
  static final Config _singleton = Config._internal();

  late final Directory appDir;
  late final Directory pdfDir;
  late final Directory dataDir;

  factory Config() {
    return _singleton;
  }

  Config._internal() {
    _initializeDirectories();
  }

  void _initializeDirectories() {
    appDir = Directory.current;
    pdfDir = Directory(path.join(appDir.path, 'pdf'));
    dataDir = Directory(path.join(appDir.path, 'data'));
  }

  Future<void> createDirectories() async {
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    if (!await dataDir.exists()) {
      await dataDir.create(recursive: true);
    }
  }
}
