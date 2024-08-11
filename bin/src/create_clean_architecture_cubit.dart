import 'dart:io';
import '../clean_architecture_with_state_management.dart';
import 'create_clean_architecture_bloc.dart';

/// Creates the necessary files for a clean architecture using the Cubit pattern.
///
/// The function takes a [featureName] as a parameter, which is used to generate
/// the file names and directory structure. It first adds the BLoC package to the
/// project by calling the `addBlocPackage` function. Then, it creates the Cubit
/// files for the specified [featureName] by calling the `addCubitFiles` function.
/// After that, it creates the injection container file for the [featureName] by
/// calling the `createInjectionContainerFile` function.
///
/// Parameters:
/// - `featureName`: A `String` representing the name of the feature for which the
///   files will be created.
///
/// Returns:
/// - A `Future` that completes when all the necessary files have been created.
Future createCleanArchitectureCubitFiles(String featureName) async {
  await addBlocPackage();

  createInjectionContainerFile(featureName);
  addCubitFiles(featureName);
}

/// Creates the necessary Cubit files for a feature in the presentation layer.
///
/// This function takes a [featureName] as a parameter, which is used to generate
/// the file names and directory structure. It creates the Cubit file and the
/// state file for the specified [featureName] in the presentation layer.
///
/// Parameters:
/// - `featureName`: A `String` representing the name of the feature for which the
///   Cubit files will be created.
///
/// Returns:
/// - `void`
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

// Creates an injection container file for the specified featureName. This function generates the necessary import statements and registration of cubit, repository, use cases, and data sources for the feature. It also includes a comment to call this function in the ServiceLocator.setup() function.
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
