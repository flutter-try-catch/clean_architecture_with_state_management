import 'dart:io';
import '../clean_architecture_with_state_management.dart';

Future createCleanArchitectureBlocFiles(String featureName) async {
  await addBlocPackage();

  addBlocFiles(featureName);
  // createInitParamsFile(featureName);
  createInjectionContainerFile(featureName);
}

// void createDirectories(String featureName) {
//   Directory('lib/features/${featureName.toSnakeCase()}/data/data_sources/local')
//       .createSync(recursive: true);
//   Directory(
//           'lib/features/${featureName.toSnakeCase()}/data/data_sources/remote')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/data/models')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/data/repositories')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/domain/entities')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/domain/repositories')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/domain/use_cases')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/presentation/bloc')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/presentation/widgets')
//       .createSync(recursive: true);
//   Directory('lib/features/${featureName.toSnakeCase()}/presentation/screens')
//       .createSync(recursive: true);
// }

void addBlocFiles(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/bloc')
      .createSync(recursive: true);
  File('lib/features/${featureName.toSnakeCase()}/presentation/bloc/${featureName.toSnakeCase()}_bloc.dart')
      .writeAsStringSync('''
import '../../domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName.toSnakeCase()}_event.dart';
part '${featureName.toSnakeCase()}_state.dart';

class ${featureName.capitalize()}Bloc extends Bloc<${featureName.capitalize()}Event, ${featureName.capitalize()}State> {
  final ${featureName.capitalize()}UseCase ${featureName}UseCase;

  ${featureName.capitalize()}Bloc({required this.${featureName}UseCase}) : super(const ${featureName.capitalize()}Initial()) {
    on<${featureName.capitalize()}Event>(_${featureName.toLowerCaseFirst()});
  }

  Future<void> _${featureName.toLowerCaseFirst()}(
    ${featureName.capitalize()}Event event,
    Emitter<${featureName.capitalize()}State> emit,
  ) async {
    emit(const ${featureName.capitalize()}Loading());
    final result = await ${featureName}UseCase.call();
    result.fold(
      (exception) => emit(${featureName.capitalize()}Error(exception)),
      (_) => emit(const ${featureName.capitalize()}Loaded()),
    );
  }
}

      ''');

  // event file
  File('lib/features/${featureName.toSnakeCase()}/presentation/bloc/${featureName.toSnakeCase()}_event.dart')
      .writeAsStringSync('''
part of '${featureName.toSnakeCase()}_bloc.dart';
 class ${featureName.capitalize()}Event {
  const ${featureName.capitalize()}Event();
}
      ''');

  // state file
  File('lib/features/${featureName.toSnakeCase()}/presentation/bloc/${featureName.toSnakeCase()}_state.dart')
      .writeAsStringSync('''
part of '${featureName.toSnakeCase()}_bloc.dart';
abstract class ${featureName.capitalize()}State {
  const ${featureName.capitalize()}State();
}

class ${featureName.capitalize()}Initial extends ${featureName.capitalize()}State {
  const ${featureName.capitalize()}Initial();
}
class ${featureName.capitalize()}Loading extends ${featureName.capitalize()}State {
  const ${featureName.capitalize()}Loading();
}
class ${featureName.capitalize()}Loaded extends ${featureName.capitalize()}State {
  const ${featureName.capitalize()}Loaded();
}
class ${featureName.capitalize()}Error extends ${featureName.capitalize()}State {
  final Exception exception;
  const ${featureName.capitalize()}Error(this.exception);
}

''');

  File('lib/features/${featureName.toSnakeCase()}/presentation/screens/${featureName.toSnakeCase()}_screen.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/${featureName.toSnakeCase()}_bloc.dart';

class ${featureName.capitalize()}Screen extends StatefulWidget {
  const ${featureName.capitalize()}Screen({super.key});
  @override
  State<${featureName.capitalize()}Screen> createState() => _${featureName.capitalize()}State();
}

class _${featureName.capitalize()}State extends State<${featureName.capitalize()}Screen> {
  late ${featureName.capitalize()}Bloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<${featureName.capitalize()}Bloc>();
    _bloc.add(${featureName.capitalize()}Event());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<${featureName.capitalize()}Bloc, ${featureName.capitalize()}State>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(${featureName.capitalize()}State state) {
    if (state is ${featureName.capitalize()}Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ${featureName.capitalize()}Loaded) {
      return Placeholder(); // Replace with your actual widget
    } else if (state is ${featureName.capitalize()}Error) {
      return Center(
        child: Text('Error: '),
      );
    } else {
      return Container();
    }
  }
}
      ''');
}

void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/inject_${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
import '../../injection_container.dart';
import 'data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';
import 'data/repositories/${featureName.toSnakeCase()}_repository_impl.dart';
import 'domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import 'domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'presentation/bloc/${featureName.toSnakeCase()}_bloc.dart';

//call this function in ServiceLocator.setup() function
inject${featureName.capitalize()}() {
  // bloc
  getIt.registerFactory(() => ${featureName.capitalize()}Bloc(${featureName}UseCase: getIt()));

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

Future<void> addBlocPackage() async {
  // Add the Bloc and flutter_bloc Provider packages
  final result = await Process.run(
    'flutter',
    ['pub', 'add', 'bloc', 'flutter_bloc'],
    runInShell: true,
  );

  // Check if the process completed successfully
  if (result.exitCode == 0) {
    print('Bloc package added successfully');
  } else {
    print('Failed to add Bloc package: ${result.stderr}');
  }
}
