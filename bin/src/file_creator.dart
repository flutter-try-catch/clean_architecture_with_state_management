import 'dart:io';
import 'cli_helper.dart';

/// Global state management for file creation
class FileCreator {
  static bool _dryRun = false;
  static int _filesCreated = 0;

  static void setDryRun(bool value) {
    _dryRun = value;
  }

  static bool getDryRun() {
    return _dryRun;
  }

  static void incrementFilesCreated() {
    _filesCreated++;
  }

  static int getFilesCreated() {
    return _filesCreated;
  }

  static void resetFilesCreated() {
    _filesCreated = 0;
  }

  /// Create a file with content and track progress
  static void createFile(String path, String content) {
    if (_dryRun) {
      CLIHelper.fileCreated('$path (dry-run)');
      _filesCreated++;
    } else {
      final file = File(path);
      if (file.existsSync()) {
        CLIHelper.fileSkipped('$path (already exists)');
      } else {
        file.writeAsStringSync(content);
        CLIHelper.fileCreated(path);
        _filesCreated++;
      }
    }
  }

  /// Create directory
  static void createDirectory(String path) {
    if (!_dryRun) {
      Directory(path).createSync(recursive: true);
    }
  }
}

