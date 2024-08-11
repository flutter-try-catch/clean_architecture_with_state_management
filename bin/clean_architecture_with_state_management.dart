library clean_architecture_with_state_management;

import 'dart:developer';
import 'dart:io';

import 'src/create_clean_architecture.dart';
import 'src/create_clean_architecture_bloc.dart';
import 'src/create_clean_architecture_cubit.dart';
import 'src/create_clean_architecture_provider.dart';
import 'src/create_clean_architecture_riverpod.dart';

// Main function to handle the initialization of a feature and create clean architecture files based on the provided state management option.
void main(List<String> args) async {
  if (args.isEmpty) {
    log('Please provide a feature name.', name: 'Error');
    return;
  }

  final featureName = args[0];
  await init(featureName);

  await createCleanArchitectureFiles(featureName);

  if (args.length > 1) {
    switch (args[1]) {
      case '-provider':
        await createCleanArchitectureProviderFiles(featureName);
        break;
      case '-bloc':
        await createCleanArchitectureBlocFiles(featureName);
        break;
      case '-cubit':
        await createCleanArchitectureCubitFiles(featureName);
        break;
      case '-riverpod':
        await createCleanArchitectureRiverpodFiles(featureName);
        break;
      default:
        log('Invalid state management option. Use -provider, -bloc, -cubit, or -riverpod.', name: 'Error');
        return;
    }
  }
  
  addFilesToGit();
}

/// Initializes the feature by creating the injection container file if it doesn't exist.
///
/// This function checks if the file 'lib/injection_container.dart' exists. If it doesn't, 
/// the function creates the file and writes the necessary import statements and class 
/// definition for the injection container.
///
/// Parameters:
/// - `featureName` (String): The name of the feature to be initialized.
///
/// Returns:
/// - `Future<void>`: A future that completes when the initialization is done.
Future init(String featureName) async {
  // Check if the file exists, if not, create it
  final file = File('lib/injection_container.dart');
  if (!file.existsSync()) {
    await file.create(recursive: true);
    await file.writeAsString('''
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

// how to use
/**
 * Future.wait([
    ServiceLocator().setup(),
    ]).then((value) {
    runApp(const MyApp());
    });
 * **/
class ServiceLocator {
  Future<void> setup() async {
    
  }
}
''');
  }
}

/// Adds all files in the current directory to the Git staging area.
///
/// This function uses the `Process.run` method to execute the `git add .` command.
/// It then checks the exit code of the command to determine whether the operation was successful.
///
/// Parameters:
/// - None
///
/// Returns:
/// - None
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
  // Capitalizes the first letter of a string and returns the modified string. 
  String capitalize() {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
  }

  /// Converts the first character of the string to lowercase and returns the modified string.
  ///
  /// If the string is empty, the original string is returned.
  ///
  /// Returns:
  ///   - The modified string with the first character in lowercase.
  ///
  /// Example:
  /// ```dart
  /// String str = "Hello";
  /// String lowerCaseFirst = str.toLowerCaseFirst();
  /// print(lowerCaseFirst); // Output: "hello"
  /// ```
  String toLowerCaseFirst() {
    return isNotEmpty ? this[0].toLowerCase() + substring(1) : this;
  }

  /// Converts a string to snake case.
  ///
  /// Replaces all uppercase characters with their lowercase equivalent preceded by an underscore.
  /// Also replaces all whitespace characters with an underscore.
  ///
  /// Returns:
  ///   - The modified string in snake case.
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) {
      return '_${match.group(1)!.toLowerCase()}';
    }).replaceAll(RegExp(r'\s+'), '_');
  }
}
