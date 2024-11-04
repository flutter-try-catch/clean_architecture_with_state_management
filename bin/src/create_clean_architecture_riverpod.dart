import 'dart:io';

import '../clean_architecture_with_state_management.dart';

/// Creates the necessary files for a clean architecture using the Riverpod pattern.
Future<void> createCleanArchitectureRiverpodFiles(String featureName) async {
  await addRiverpodPackage();

  addProviderFiles(featureName);
  createInjectionContainerFile(featureName);
}

void addProviderFiles(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/provider')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/screens')
      .createSync(recursive: true);

  File('lib/features/${featureName.toSnakeCase()}/presentation/provider/${featureName.toSnakeCase()}_state.dart')
      .writeAsStringSync('''
abstract class ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Initial extends ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Loading extends ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Loaded extends ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Error extends ${featureName.capitalize()}State {
  final Exception exception;
  ${featureName.capitalize()}Error({required this.exception});
}
      ''');

  File('lib/features/${featureName.toSnakeCase()}/presentation/provider/${featureName.toSnakeCase()}_provider.dart')
      .writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import '${featureName.toSnakeCase()}_state.dart';
import '../../inject_${featureName.toSnakeCase()}.dart';

final ${featureName}Provider = StateNotifierProvider<${featureName.capitalize()}Provider, ${featureName.capitalize()}State>((ref) {
  return ${featureName.capitalize()}Provider(${featureName}UseCase: ref.read(${featureName}UseCaseProvider));
});

class ${featureName.capitalize()}Provider extends StateNotifier<${featureName.capitalize()}State> {

  final ${featureName.capitalize()}UseCase ${featureName}UseCase;
  ${featureName.capitalize()}Provider({required this.${featureName}UseCase}) : super(${featureName.capitalize()}Initial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      ''');

  File('lib/features/${featureName.toSnakeCase()}/presentation/screens/${featureName.toSnakeCase()}_screen.dart')
    .writeAsStringSync(generateScreenCode(featureName));
}

String generateScreenCode(String featureName) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/${featureName.toSnakeCase()}_provider.dart';
import '../provider/${featureName.toSnakeCase()}_state.dart';

class ${featureName.capitalize()}Screen extends ConsumerWidget {
  static const String routeName = '/${featureName.toLowerCase()}';
  const ${featureName.capitalize()}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${featureName.toLowerCase()}Provider);

    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            if (state is ${featureName.capitalize()}Initial) {
              return const Text('Initial State');
            } else if (state is ${featureName.capitalize()}Loading) {
              return const Text('Loading State');
            } else if (state is ${featureName.capitalize()}Loaded) {
              return const Text('Loaded State');
            }
            return const Text('Unknown State');
          },
        ),
      ),
    );
  }
}
''';
}

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
import 'presentation/provider/${featureName.toSnakeCase()}_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final ${featureName}Provider =
    StateNotifierProvider<${featureName.capitalize()}Provider, ${featureName.capitalize()}State>((ref) {
  return ${featureName.capitalize()}Provider(
      ${featureName}UseCase: ref.read(${featureName}UseCaseProvider));
});
// Repository
final ${featureName}RepositoryProvider = Provider<${featureName.capitalize()}Repository>((ref) =>
    ${featureName.capitalize()}RepositoryImpl(
        remoteDataSource: ref.watch((${featureName}DataSourceProvider))));

// UseCases
final ${featureName}UseCaseProvider = Provider<${featureName.capitalize()}UseCase>(
    (ref) => ${featureName.capitalize()}UseCase(ref.watch(${featureName}RepositoryProvider)));

// DataSources
final ${featureName}DataSourceProvider = Provider<${featureName.capitalize()}RemoteDataSource>(
    (ref) => ${featureName.capitalize()}RemoteDataSourceImpl());


''');
}

Future<void> addRiverpodPackage() async {
  final result = await Process.run(
    'flutter',
    ['pub', 'add', 'flutter_riverpod'],
    runInShell: true,
  );

  if (result.exitCode == 0) {
    print('Riverpod package added successfully');
  } else {
    print('Failed to add Riverpod package: ${result.stderr}');
  }
}
