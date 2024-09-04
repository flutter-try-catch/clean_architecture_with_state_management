import 'dart:io';
import '../clean_architecture_with_state_management.dart';

// Creates all the necessary files for a clean architecture related to the given featureName.
Future createCleanArchitectureFiles(String featureName) async {
  createDirectories(featureName);
  createDataFiles(featureName);
  createDomainFiles(featureName);
  createPresentationFiles(featureName);
  // createInitParamsFile(featureName);
  createInjectionContainerFile(featureName);
}

/// Creates the necessary directories for a clean architecture feature.
///
/// This function takes a [featureName] as input and creates the following directories:
/// - data/data_sources/local
/// - data/data_sources/remote
/// - data/models
/// - data/repositories
/// - domain/entities
/// - domain/repositories
/// - domain/use_cases
/// - presentation/widgets
/// - presentation/screens
///
/// The directories are created recursively under the 'lib/features/[featureName]' directory.
///
/// Parameters:
///   featureName (String): The name of the feature for which the directories are created.
///
/// Returns:
///   void
void createDirectories(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/data/data_sources/local')
      .createSync(recursive: true);
  Directory(
          'lib/features/${featureName.toSnakeCase()}/data/data_sources/remote')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/models')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/repositories')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/entities')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/repositories')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/use_cases')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/widgets')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/screens')
      .createSync(recursive: true);
}

/// Creates data files for a feature.
///
/// The files created include local data source, remote data source, model, and repository implementation.
///
/// Parameters:
///   featureName (String): The name of the feature for which the data files are created.
///
/// Returns:
///   void
void createDataFiles(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/data/data_sources/local/${featureName.toSnakeCase()}_local_data_source.dart')
      .writeAsStringSync('''
import 'package:dartz/dartz.dart';


abstract class ${featureName.capitalize()}LocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class ${featureName.capitalize()}LocalDataSourceImpl implements ${featureName.capitalize()}LocalDataSource {
  ${featureName.capitalize()}LocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  ''');
  File('lib/features/${featureName.toSnakeCase()}/data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart')
      .writeAsStringSync('''
import 'package:dartz/dartz.dart';


abstract class ${featureName.capitalize()}RemoteDataSource {
  Future<Unit> callApi();
}

class ${featureName.capitalize()}RemoteDataSourceImpl implements ${featureName.capitalize()}RemoteDataSource {
  ${featureName.capitalize()}RemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  ''');
  File('lib/features/${featureName.toSnakeCase()}/data/models/${featureName.toSnakeCase()}_model.dart')
      .writeAsStringSync('''
import '../../domain/entities/${featureName.toSnakeCase()}.dart';

class ${featureName.capitalize()}Model extends ${featureName.capitalize()} {
  const ${featureName.capitalize()}Model(
      {required String data})
      : super(data: data);

  ${featureName.capitalize()}Model copyWith({
    String? data,
  }) {
    return ${featureName.capitalize()}Model(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory ${featureName.capitalize()}Model.fromJson(Map<String, dynamic> json) => ${featureName.capitalize()}Model(
    data: json["data"],
  );
}

''');
  File('lib/features/${featureName.toSnakeCase()}/data/repositories/${featureName.toSnakeCase()}_repository_impl.dart')
      .writeAsStringSync('''
import 'package:dartz/dartz.dart';
import '../../domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import '../data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';


class ${featureName.capitalize()}RepositoryImpl implements ${featureName.capitalize()}Repository {
  final ${featureName.capitalize()}RemoteDataSource remoteDataSource;

  ${featureName.capitalize()}RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

''');
}

// Creates domain files for a feature including entity, repository, and use case.
void createDomainFiles(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/domain/entities/${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
class ${featureName.capitalize()} {
  final String? data;

  const ${featureName.capitalize()}({
    required this.data,
  });

}
''');
  File('lib/features/${featureName.toSnakeCase()}/domain/repositories/${featureName.toSnakeCase()}_repository.dart')
      .writeAsStringSync('''
import 'package:dartz/dartz.dart';


abstract class ${featureName.capitalize()}Repository {
  Future<Either<Exception, Unit>> callApi();
}

''');
  File('lib/features/${featureName.toSnakeCase()}/domain/use_cases/${featureName.toSnakeCase()}_use_case.dart')
      .writeAsStringSync('''
import 'package:dartz/dartz.dart';
import '../repositories/${featureName.toSnakeCase()}_repository.dart';


class ${featureName.capitalize()}UseCase {
  final ${featureName.capitalize()}Repository repository;

  ${featureName.capitalize()}UseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

''');
}

/// Creates a presentation file for the given featureName, generating a screen
/// with a basic Scaffold and a Placeholder widget.
///
/// Parameters:
///   featureName (String): The name of the feature for which the presentation file is being created.
///
/// Returns:
///   void
void createPresentationFiles(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/presentation/screens/${featureName.toSnakeCase()}_screen.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';

class ${featureName.capitalize()}Screen extends StatefulWidget {
  const ${featureName.capitalize()}Screen({super.key});
  @override
  State<${featureName.capitalize()}Screen> createState() => _${featureName.capitalize()}State();
}

class _${featureName.capitalize()}State extends State<${featureName.capitalize()}Screen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Placeholder());
  }
}
      ''');
}

/// Creates an initialization parameters file for the given feature.
///
/// Parameters:
///   featureName (String): The name of the feature for which the initialization parameters file is being created.
///
/// Returns:
///   void
void createInitParamsFile(String featureName) {
  // File('lib/features/${featureName.toSnakeCase()}/${featureName.toSnakeCase()}_init_params.dart')
  //     .createSync(recursive: true);
}

// Creates an injection container file for the given featureName, importing necessary dependencies and registering repository, use cases, and data sources. This function also includes a comment to call the generated function in the ServiceLocator setup.
void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/inject_${featureName.toSnakeCase()}.dart')
      .writeAsStringSync('''
import '../../injection_container.dart';
import 'data/data_sources/remote/${featureName.toSnakeCase()}_remote_data_source.dart';
import 'data/repositories/${featureName.toSnakeCase()}_repository_impl.dart';
import 'domain/repositories/${featureName.toSnakeCase()}_repository.dart';
import 'domain/use_cases/${featureName.toSnakeCase()}_use_case.dart';

//call this function in ServiceLocator.setup() function
inject${featureName.capitalize()}() {

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
