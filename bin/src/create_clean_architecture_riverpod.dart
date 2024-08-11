import 'dart:io';
import '../clean_architecture_with_state_management.dart';

/// Creates the necessary files for a clean architecture using the Riverpod pattern.
///
/// The function takes a [featureName] as a parameter, which is used to generate
/// the file names and directory structure. It first adds the Riverpod package to
/// the project, then adds the Riverpod files for the specified [featureName],
/// and finally creates the injection container file for the [featureName].
///
/// Parameters:
/// - `featureName`: A `String` representing the name of the feature for which the
///   files will be created.
///
/// Returns:
/// - A `Future` that completes when all the necessary files have been created.
Future createCleanArchitectureRiverpodFiles(String featureName) async {
  await addRiverpodPackage();

  addRiverpodFiles(featureName);
  createInjectionContainerFile(featureName);
}

void addRiverpodFiles(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/riverpod')
      .createSync(recursive: true);
  
  File('lib/features/${featureName.toSnakeCase()}/presentation/riverpod/${featureName.toSnakeCase()}_provider.dart')
      .writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import '../../inject_${featureName.toSnakeCase()}.dart';

final ${featureName.toLowerCaseFirst()}Provider = StateNotifierProvider<${featureName.capitalize()}Notifier, ${featureName.capitalize()}State>((ref) {
  return ${featureName.capitalize()}Notifier(${featureName}UseCase: ref.watch(${featureName.toLowerCaseFirst()}UseCaseProvider));
});

class ${featureName.capitalize()}Notifier extends StateNotifier<${featureName.capitalize()}State> {
  final ${featureName.capitalize()}UseCase ${featureName}UseCase;

  ${featureName.capitalize()}Notifier({required this.${featureName}UseCase}) : super(${featureName.capitalize()}Initial());

  Future<void> fetchData() async {
    state = ${featureName.capitalize()}Loading();
    final result = await ${featureName}UseCase.call();
    result.fold(
      (exception) => state = ${featureName.capitalize()}Error(exception),
      (_) => state = ${featureName.capitalize()}Loaded(),
    );
  }
}

abstract class ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Initial extends ${featureName.capitalize()}State {}
class ${featureName.capitalize()}Loading extends ${featureName.capitalize()}State {}
class ${featureName.capitalize()}Loaded extends ${featureName.capitalize()}State {}
class ${featureName.capitalize()}Error extends ${featureName.capitalize()}State {
  final Exception exception;
  ${featureName.capitalize()}Error(this.exception);
}
      ''');

  File('lib/features/${featureName.toSnakeCase()}/presentation/screens/${featureName.toSnakeCase()}_screen.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/${featureName.toSnakeCase()}_provider.dart';

class ${featureName.capitalize()}Screen extends ConsumerWidget {
  const ${featureName.capitalize()}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${featureName.toLowerCaseFirst()}Provider);

    return Scaffold(
      appBar: AppBar(title: Text('${featureName.capitalize()}')),
      body: _buildBody(state),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(${featureName.toLowerCaseFirst()}Provider.notifier).fetchData(),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(${featureName.capitalize()}State state) {
    if (state is ${featureName.capitalize()}Loading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is ${featureName.capitalize()}Loaded) {
      return Center(child: Text('Data loaded successfully'));
    } else if (state is ${featureName.capitalize()}Error) {
      return Center(child: Text('Error: \${state.exception}'));
    } else {
      return Center(child: Text('Press the button to load data'));
    }
  }
}
      ''');
}

/// Creates an injection container file for the specified featureName. This function generates the necessary import statements and registration of providers for the feature.
/// 
/// Parameters:
///   featureName (String): The name of the feature.
/// 
/// Returns:
///   void
void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/inject_${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';
import 'data/repositories/${featureName.toSnakeCase()}_repository_impl.dart';
import 'domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import 'domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';

final ${featureName.toLowerCaseFirst()}RemoteDataSourceProvider = Provider<${featureName.capitalize()}RemoteDataSource>(
  (ref) => ${featureName.capitalize()}RemoteDataSourceImpl(),
);

final ${featureName.toLowerCaseFirst()}RepositoryProvider = Provider<${featureName.capitalize()}Repository>(
  (ref) => ${featureName.capitalize()}RepositoryImpl(remoteDataSource: ref.watch(${featureName.toLowerCaseFirst()}RemoteDataSourceProvider)),
);

final ${featureName.toLowerCaseFirst()}UseCaseProvider = Provider<${featureName.capitalize()}UseCase>(
  (ref) => ${featureName.capitalize()}UseCase(ref.watch(${featureName.toLowerCaseFirst()}RepositoryProvider)),
);
      ''');
}

/// Adds the Riverpod package to the project.
/// 
/// This function runs the `flutter pub add flutter_riverpod` command and checks the result.
/// If the command is successful, it prints a success message. Otherwise, it prints an error message.
/// 
/// Returns:
///   Future<void>
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