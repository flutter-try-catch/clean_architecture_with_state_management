library clean_architecture_with_state_management;

import 'dart:io';
import 'package:args/args.dart';

import 'src/cli_helper.dart';
import 'src/file_creator.dart';
import 'src/create_clean_architecture.dart';
import 'src/create_clean_architecture_bloc.dart';
import 'src/create_clean_architecture_cubit.dart';
import 'src/create_clean_architecture_provider.dart';
import 'src/create_clean_architecture_riverpod.dart';

// Global variables
bool _skipGit = false;

/// Main function to handle the CLI interaction
void main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show help information')
    ..addFlag('interactive', abbr: 'i', negatable: false, help: 'Force interactive mode')
    ..addFlag('dry-run', abbr: 'd', negatable: false, help: 'Preview without creating files')
    ..addFlag('provider', abbr: 'p', negatable: false, help: 'Use Provider state management')
    ..addFlag('bloc', abbr: 'b', negatable: false, help: 'Use Bloc state management')
    ..addFlag('cubit', abbr: 'c', negatable: false, help: 'Use Cubit state management')
    ..addFlag('riverpod', abbr: 'r', negatable: false, help: 'Use Riverpod state management')
    ..addFlag('no-git', negatable: false, help: 'Skip git add step');

  try {
    final argResults = parser.parse(args);

    // Show help
    if (argResults['help'] as bool) {
      CLIHelper.printHelp();
      return;
    }

    // Set global flags
    final dryRun = argResults['dry-run'] as bool;
    FileCreator.setDryRun(dryRun);
    _skipGit = argResults['no-git'] as bool;

    // Determine mode: interactive or command-line
    final forceInteractive = argResults['interactive'] as bool;
    final hasFeatureName = argResults.rest.isNotEmpty;
    
    if (!hasFeatureName || forceInteractive) {
      // Interactive mode
      await _runInteractiveMode();
    } else {
      // Command-line mode
      final featureName = argResults.rest[0];
      
      // Validate feature name
      if (!CLIHelper.isValidFeatureName(featureName)) {
        CLIHelper.error('Invalid feature name: "$featureName"');
        CLIHelper.info('Feature names must:');
        CLIHelper.info('  • Start with a letter (a-z, A-Z)');
        CLIHelper.info('  • Contain only letters, numbers, and underscores');
        CLIHelper.info('  • Example: user, user_profile, myFeature');
        exit(1);
      }
      
      String? stateManagement;

      // Determine state management from flags
      if (argResults['provider'] as bool) {
        stateManagement = 'provider';
      } else if (argResults['bloc'] as bool) {
        stateManagement = 'bloc';
      } else if (argResults['cubit'] as bool) {
        stateManagement = 'cubit';
      } else if (argResults['riverpod'] as bool) {
        stateManagement = 'riverpod';
      }

      await _runCommandMode(featureName, stateManagement);
    }
  } catch (e) {
    CLIHelper.error('Error: $e');
    CLIHelper.info('Run with --help for usage information');
    exit(1);
  }
}

/// Run in interactive mode with prompts
Future<void> _runInteractiveMode() async {
  CLIHelper.printWelcome();
  CLIHelper.printTips();

  // Ask for feature name
  CLIHelper.section('Feature Setup');
  final featureName = CLIHelper.input(
    'What is the name of your feature?',
    defaultValue: 'user',
  );

  // Ask for state management
  final wantsStateManagement = CLIHelper.confirm(
    'Do you want to add state management?',
    defaultValue: true,
  );

  String? stateManagement;
  if (wantsStateManagement) {
    stateManagement = CLIHelper.select(
      'Choose your state management solution:',
      ['Provider', 'Bloc', 'Cubit', 'Riverpod'],
    ).toLowerCase();
  }

  // Show summary
  print('');
  CLIHelper.printSummary(
    featureName: featureName,
    stateManagement: stateManagement,
    dryRun: FileCreator.getDryRun(),
  );

  // Confirm before proceeding
  print('');
  final shouldProceed = CLIHelper.confirm(
    'Ready to generate files?',
    defaultValue: true,
  );

  if (!shouldProceed) {
    CLIHelper.warning('Operation cancelled by user');
    return;
  }

  // Generate files
  await _generateFeature(featureName, stateManagement);
}

/// Run in command-line mode with args
Future<void> _runCommandMode(String featureName, String? stateManagement) async {
  CLIHelper.header('Clean Architecture Generator');
  
  CLIHelper.printSummary(
    featureName: featureName,
    stateManagement: stateManagement,
    dryRun: FileCreator.getDryRun(),
  );

  await _generateFeature(featureName, stateManagement);
}

/// Generate the feature files
Future<void> _generateFeature(String featureName, String? stateManagement) async {
  FileCreator.resetFilesCreated();
  
  try {
    // Check if feature already exists
    final featurePath = 'lib/features/${featureName.toSnakeCase()}';
    final featureDir = Directory(featurePath);
    
    if (featureDir.existsSync() && !FileCreator.getDryRun()) {
      CLIHelper.warning('Feature "$featureName" already exists!');
      print('');
      
      final shouldOverride = CLIHelper.confirm(
        'Do you want to override the existing feature?',
        defaultValue: false,
      );
      
      if (!shouldOverride) {
        CLIHelper.info('Operation cancelled. Existing feature was not modified.');
        return;
      }
      
      // Delete existing feature
      CLIHelper.section('Removing Existing Feature');
      CLIHelper.step('Deleting $featurePath...');
      featureDir.deleteSync(recursive: true);
      CLIHelper.success('Existing feature removed');
      print('');
    }
    
    if (FileCreator.getDryRun()) {
      CLIHelper.warning('DRY RUN MODE - No files will be created');
      print('');
    }

    // Initialize
    CLIHelper.section('Initializing');
    await CLIHelper.spinner('Setting up injection container', () async {
      await init(featureName);
    });

    // Create base architecture
    CLIHelper.section('Creating Clean Architecture Structure');
    await createCleanArchitectureFiles(featureName);

    // Create state management files if needed
    if (stateManagement != null) {
      CLIHelper.section('Adding ${stateManagement.capitalize()} State Management');
      
      switch (stateManagement) {
        case 'provider':
          await createCleanArchitectureProviderFiles(featureName);
          break;
        case 'bloc':
          await createCleanArchitectureBlocFiles(featureName);
          break;
        case 'cubit':
          await createCleanArchitectureCubitFiles(featureName);
          break;
        case 'riverpod':
          await createCleanArchitectureRiverpodFiles(featureName);
          break;
      }
    }

    // Add to git
    if (!_skipGit && !FileCreator.getDryRun()) {
      CLIHelper.section('Adding to Git');
      await CLIHelper.spinner('Running git add', () async {
        await addFilesToGit();
      });
    }

    // Success message
    CLIHelper.complete(
      'Feature "$featureName" generated successfully!',
      filesCreated: FileCreator.getFilesCreated(),
    );

    // Next steps
    CLIHelper.section('Next Steps');
    CLIHelper.step('1. Update your dependency injection in injection_container.dart');
    CLIHelper.step('2. Implement your business logic in the use case');
    CLIHelper.step('3. Add your UI in the presentation layer');
    CLIHelper.step('4. Start coding! 🚀');
    print('');

  } catch (e) {
    CLIHelper.error('Failed to generate feature: $e');
    exit(1);
  }
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
/// - Future<void>
Future<void> addFilesToGit() async {
  final result = await Process.run('git', ['add', '.']);
  if (result.exitCode == 0) {
    CLIHelper.success('All files added to Git');
  } else {
    CLIHelper.error('Failed to add files to Git: ${result.stderr}');
  }
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
