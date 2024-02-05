import 'dart:developer';
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    log('Please provide a feature name.', name: 'Error');
    return;
  }

  final featureName = args[0];
  createCleanArchitectureFiles(featureName);
  addFilesToGit();
}

void createCleanArchitectureFiles(String featureName) async {
  createDirectories(featureName);
  createDataFiles(featureName);
  createDomainFiles(featureName);
  createPresentationFiles(featureName);
  // createInitParamsFile(featureName);
  // createInjectionContainerFile(featureName);
}

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
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/provider')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/widgets')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/screens')
      .createSync(recursive: true);
}

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

void createPresentationFiles(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/presentation/provider/${featureName.toSnakeCase()}_provider.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';

class ${featureName.toSnakeCase()}Manager extends ChangeNotifier {
  ${featureName.toSnakeCase()}Manager() {
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

class ${featureName.capitalize()}Screen extends StatefulWidget {
  const ${featureName.capitalize()}Screen({super.key});
  @override
  State<${featureName.capitalize()}Screen> createState() => _${featureName.capitalize()}State();
}

class _${featureName.capitalize()}State extends State<${featureName.capitalize()}Screen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Placeholder()
    );
  }
}
      ''');
}

void createInitParamsFile(String featureName) {
  // File('lib/features/${featureName.toSnakeCase()}/${featureName.toSnakeCase()}_init_params.dart')
  //     .createSync(recursive: true);
}

void createInjectionContainerFile(String featureName) {
  File('lib/features/${featureName.toSnakeCase()}/injection_container.dart')
      .writeAsStringSync('''
import 'data/data_sources/profile_remote_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/use_cases/profile_use_case.dart';
import 'presentation/manager/profile_manager.dart';

injectProfile() {
  // Providers
  getIt.registerFactory(() => ${featureName.capitalize()}Manager(${featureName.capitalize()}UseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<${featureName.capitalize()}Repository>(
          () => ${featureName.capitalize()}RepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => ${featureName.capitalize()}UseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<${featureName.capitalize()}RemoteDataSource>(
          () => ${featureName.capitalize()}RemoteDataSourceImpl(apiProvider: getIt()));
}
      ''');
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

