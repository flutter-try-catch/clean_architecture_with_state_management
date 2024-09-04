import 'dart:io';
import '../clean_architecture_with_state_management.dart';

/// Creates the necessary files for a clean architecture using the Provider pattern.
///
/// The function takes a [featureName] as a parameter, which is used to generate
/// the file names and directory structure. It first adds the Provider package to
/// the project by calling the `addProviderPackage` function. Then, it adds the
/// Provider files for the specified [featureName] by calling the `addProviderFiles`
/// function. After that, it creates the injection container file for the
/// [featureName] by calling the `createInjectionContainerFile` function.
///
/// Parameters:
/// - `featureName`: A `String` representing the name of the feature for which the
///   files will be created.
///
/// Returns:
/// - A `Future` that completes when all the necessary files have been created.
Future createCleanArchitectureProviderFiles(String featureName) async {
  await addProviderPackage();

  addProviderFiles(featureName);
  // createInitParamsFile(featureName);
  createInjectionContainerFile(featureName);
}

void addProviderFiles(String featureName) {
  //Create directories
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/provider')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/screens')
      .createSync(recursive: true);

  File('lib/features/${featureName.toSnakeCase()}/presentation/provider/${featureName.toSnakeCase()}_provider.dart')
      .writeAsStringSync('''
import '../../domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'package:flutter/material.dart';

class ${featureName.capitalize()}Provider extends ChangeNotifier {

  final ${featureName.capitalize()}UseCase ${featureName}UseCase;
  ${featureName.capitalize()}Provider({required this.${featureName}UseCase}) {
    init();
  }

  void init() async {

  }
}

      ''');
  // File('lib/features/${featureName.toSnakeCase()}/presentation/widgets/${featureName.toSnakeCase()}_widget.dart')
  //     .createSync(recursive: true);
  File('lib/features/${featureName.toSnakeCase()}/presentation/screens/${featureName.toSnakeCase()}_screen.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../provider/${featureName.toSnakeCase()}_provider.dart';

class ${featureName.capitalize()}Screen extends StatefulWidget {
  static const routeName = "/${featureName.toSnakeCase()}";
  const ${featureName.capitalize()}Screen({super.key});
  @override
  State<${featureName.capitalize()}Screen> createState() => _${featureName.capitalize()}State();
}

class _${featureName.capitalize()}State extends State<${featureName.capitalize()}Screen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<${featureName.capitalize()}Provider>(),
        child: Consumer<${featureName.capitalize()}Provider>(
          builder: (context, provider, child) {
            return const Scaffold(
              body: Placeholder()
            );
          },
        ));
  }
}
      ''');
}

// void createInitParamsFile(String featureName) {
//   // File('lib/features/${featureName.toSnakeCase()}/${featureName.toSnakeCase()}_init_params.dart')
//   //     .createSync(recursive: true);
// }

// Creates an injection container file for the given feature.
void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/inject_${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
import '../../injection_container.dart';
import 'data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';
import 'data/repositories/${featureName.toSnakeCase()}_repository_impl.dart';
import 'domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import 'domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'presentation/provider/${featureName.toSnakeCase()}_provider.dart';

//call this function in ServiceLocator.setup() function
inject${featureName.capitalize()}() {
  // Providers
  getIt.registerFactory(() => ${featureName.capitalize()}Provider(${featureName}UseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<${featureName.capitalize()}Repository>(
          () => ${featureName.capitalize()}RepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => ${featureName.capitalize()}UseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<${featureName.capitalize()}RemoteDataSource>(
          () => ${featureName.capitalize()}RemoteDataSourceImpl());
}
      ''');
}

/// Adds the Provider package to the project using the `flutter pub add` command.
///
/// This function runs the command asynchronously and checks the exit code to determine if the package was added successfully.
///
/// Returns a Future that completes when the package addition is complete, or an error if the process fails.
Future<void> addProviderPackage() async {
  // Use Process.run to execute flutter pub add provider command
  final result = await Process.run(
    'flutter',
    ['pub', 'add', 'provider'],
    runInShell: true,
  );

  // Check if the process completed successfully
  if (result.exitCode == 0) {
    print('Provider package added successfully');
  } else {
    print('Failed to add Provider package: ${result.stderr}');
  }
}
