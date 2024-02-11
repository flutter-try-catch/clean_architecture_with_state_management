library clean_architecture_with_state_management;

import 'dart:developer';
import 'dart:io';

import 'src/create_clean_architecture.dart';
import 'src/create_clean_architecture_provider.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    log('Please provide a feature name.', name: 'Error');
    return;
  }

  final featureName = args[0];
  await init(featureName);
  if(args.length == 1) {
    await createCleanArchitectureFiles(featureName);
  } else if(args[1] == '-provider'){
    await createCleanArchitectureProviderFiles(featureName);
  }
  addFilesToGit();
}

Future init(String featureName) async {
  // Check if the file exists, if not, create it
  final file = File('lib/injection_container.dart');
  if (!file.existsSync()) {
    await file.create(recursive: true);
    await file.writeAsString('''
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> setup() async {
    
  }
}
''');
  }
}
void addFilesToGit() {
  Process.run('git', ['add', '.']).then((result) {
    if (result.exitCode == 0) {
      log('All files added to Git.', name: 'INFO');
    } else {
      log('Failed to add files to Git. Error: ${result.stderr}', name: 'ERROR');
    }
  });
}

extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
  }

  String toLowerCaseFirst() {
    return isNotEmpty ? this[0].toLowerCase() + substring(1) : this;
  }

  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) {
      return '_${match.group(1)!.toLowerCase()}';
    }).replaceAll(RegExp(r'\s+'), '_');
  }
}
