import 'dart:io';
import '../clean_architecture_with_state_management.dart';
import 'create_clean_architecture_bloc.dart';

Future createCleanArchitectureCubitFiles(String featureName) async {
  await addBlocPackage();

  createInjectionContainerFile(featureName);
  addCubitFiles(featureName);
}

void addCubitFiles(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/cubit')
      .createSync(recursive: true);
  File('lib/features/${featureName.toSnakeCase()}/presentation/cubit/${featureName.toSnakeCase()}_cubit.dart')
      .writeAsStringSync('''
import '../../domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName.toSnakeCase()}_state.dart';

class ${featureName.capitalize()}Cubit extends Cubit<${featureName.capitalize()}State> {
  final ${featureName.capitalize()}UseCase ${featureName}UseCase;

  ${featureName.capitalize()}Cubit({required this.${featureName}UseCase}) : super(${featureName.capitalize()}Initial());

  Future<void> fetchData() async {
    emit(const ${featureName.capitalize()}Loading());
    final result = await ${featureName}UseCase.call();
    result.fold(
      (exception) => emit(${featureName.capitalize()}Error(exception)),
      (_) => emit(const ${featureName.capitalize()}Loaded()),
    );
  }
}

      ''');

  File('lib/features/${featureName.toSnakeCase()}/presentation/cubit/${featureName.toSnakeCase()}_state.dart')
      .writeAsStringSync('''
part of '${featureName.toSnakeCase()}_cubit.dart';

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
}

void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/inject_${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
import '../../injection_container.dart';
import 'data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';
import 'data/repositories/${featureName.toSnakeCase()}_repository_impl.dart';
import 'domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import 'domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';
import 'presentation/cubit/${featureName.toSnakeCase()}_cubit.dart';

//call this function in ServiceLocator.setup() function
inject${featureName.capitalize()}() {
  // cubit
  getIt.registerFactory(() => ${featureName.capitalize()}Cubit(${featureName}UseCase: getIt()));

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
