import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

void main() {
  group('Clean Architecture Generation Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_clean_arch_');
      Directory.current = tempDir.path;
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
    });

    group('createDirectories()', () {
      test('should create all required directories', () {
        createDirectories('user');

        // Check data layer directories
        expect(Directory('lib/features/user/data/data_sources/local').existsSync(), true);
        expect(Directory('lib/features/user/data/data_sources/remote').existsSync(), true);
        expect(Directory('lib/features/user/data/models').existsSync(), true);
        expect(Directory('lib/features/user/data/repositories').existsSync(), true);

        // Check domain layer directories
        expect(Directory('lib/features/user/domain/entities').existsSync(), true);
        expect(Directory('lib/features/user/domain/repositories').existsSync(), true);
        expect(Directory('lib/features/user/domain/use_cases').existsSync(), true);

        // Check presentation layer directories
        expect(Directory('lib/features/user/presentation/widgets').existsSync(), true);
        expect(Directory('lib/features/user/presentation/screens').existsSync(), true);
      });

      test('should create directories with snake_case names', () {
        createDirectories('UserProfile');

        expect(Directory('lib/features/_user_profile/data').existsSync(), true);
        expect(Directory('lib/features/_user_profile/domain').existsSync(), true);
        expect(Directory('lib/features/_user_profile/presentation').existsSync(), true);
      });

      test('should handle simple feature names', () {
        createDirectories('auth');

        expect(Directory('lib/features/auth/data/data_sources/local').existsSync(), true);
        expect(Directory('lib/features/auth/domain/entities').existsSync(), true);
        expect(Directory('lib/features/auth/presentation/screens').existsSync(), true);
      });
    });

    group('createDataFiles()', () {
      setUp(() {
        createDirectories('user');
      });

      test('should create local data source file', () {
        createDataFiles('user');

        final file = File('lib/features/user/data/data_sources/local/user_local_data_source.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('abstract class UserLocalDataSource'), true);
        expect(content.contains('class UserLocalDataSourceImpl'), true);
        expect(content.contains('Future<Unit> getFromLocalDataBase()'), true);
      });

      test('should create remote data source file', () {
        createDataFiles('user');

        final file = File('lib/features/user/data/data_sources/remote/user_remote_data_source.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('abstract class UserRemoteDataSource'), true);
        expect(content.contains('class UserRemoteDataSourceImpl'), true);
        expect(content.contains('Future<Unit> callApi()'), true);
      });

      test('should create model file', () {
        createDataFiles('user');

        final file = File('lib/features/user/data/models/user_model.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserModel extends User'), true);
        expect(content.contains('copyWith'), true);
        expect(content.contains('toJson'), true);
        expect(content.contains('fromJson'), true);
      });

      test('should create repository implementation file', () {
        createDataFiles('user');

        final file = File('lib/features/user/data/repositories/user_repository_impl.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserRepositoryImpl implements UserRepository'), true);
        expect(content.contains('final UserRemoteDataSource remoteDataSource'), true);
        expect(content.contains('Future<Either<Exception, Unit>> callApi()'), true);
      });

      test('should create all data files', () {
        createDataFiles('product');

        expect(File('lib/features/product/data/data_sources/local/product_local_data_source.dart').existsSync(), true);
        expect(File('lib/features/product/data/data_sources/remote/product_remote_data_source.dart').existsSync(), true);
        expect(File('lib/features/product/data/models/product_model.dart').existsSync(), true);
        expect(File('lib/features/product/data/repositories/product_repository_impl.dart').existsSync(), true);
      });

      test('should generate correct imports in data files', () {
        createDataFiles('auth');

        final modelFile = File('lib/features/auth/data/models/auth_model.dart');
        final content = modelFile.readAsStringSync();
        expect(content.contains("import '../../domain/entities/auth.dart'"), true);
      });
    });

    group('createDomainFiles()', () {
      setUp(() {
        createDirectories('user');
      });

      test('should create entity file', () {
        createDomainFiles('user');

        final file = File('lib/features/user/domain/entities/user.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class User'), true);
        expect(content.contains('final String? data'), true);
      });

      test('should create repository interface file', () {
        createDomainFiles('user');

        final file = File('lib/features/user/domain/repositories/user_repository.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('abstract class UserRepository'), true);
        expect(content.contains('Future<Either<Exception, Unit>> callApi()'), true);
      });

      test('should create use case file', () {
        createDomainFiles('user');

        final file = File('lib/features/user/domain/use_cases/user_use_case.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserUseCase'), true);
        expect(content.contains('final UserRepository repository'), true);
        expect(content.contains('Future<Either<Exception, Unit>> call()'), true);
      });

      test('should create all domain files', () {
        createDomainFiles('payment');

        expect(File('lib/features/payment/domain/entities/payment.dart').existsSync(), true);
        expect(File('lib/features/payment/domain/repositories/payment_repository.dart').existsSync(), true);
        expect(File('lib/features/payment/domain/use_cases/payment_use_case.dart').existsSync(), true);
      });

      test('should use correct naming conventions', () {
        createDomainFiles('ProductCatalog');

        final entityFile = File('lib/features/_product_catalog/domain/entities/_product_catalog.dart');
        expect(entityFile.existsSync(), true);

        final content = entityFile.readAsStringSync();
        expect(content.contains('class ProductCatalog'), true);
      });
    });

    group('createPresentationFiles()', () {
      setUp(() {
        createDirectories('user');
      });

      test('should create screen file', () {
        createPresentationFiles('user');

        final file = File('lib/features/user/presentation/screens/user_screen.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserScreen extends StatefulWidget'), true);
        expect(content.contains('class _UserState extends State<UserScreen>'), true);
        expect(content.contains('Scaffold'), true);
        expect(content.contains('Placeholder'), true);
      });

      test('should create screen with correct imports', () {
        createPresentationFiles('auth');

        final file = File('lib/features/auth/presentation/screens/auth_screen.dart');
        final content = file.readAsStringSync();
        expect(content.contains("import 'package:flutter/material.dart'"), true);
      });

      test('should create StatefulWidget with proper structure', () {
        createPresentationFiles('profile');

        final file = File('lib/features/profile/presentation/screens/profile_screen.dart');
        final content = file.readAsStringSync();
        expect(content.contains('State<ProfileScreen> createState()'), true);
        expect(content.contains('@override'), true);
        expect(content.contains('Widget build(BuildContext context)'), true);
      });
    });

    group('createInjectionContainerFile()', () {
      setUp(() {
        createDirectories('user');
      });

      test('should create injection container file', () {
        createInjectionContainerFile('user');

        final file = File('lib/features/user/inject_user.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('injectUser()'), true);
        expect(content.contains('getIt.registerLazySingleton<UserRepository>'), true);
        expect(content.contains('getIt.registerLazySingleton(() => UserUseCase'), true);
        expect(content.contains('getIt.registerLazySingleton<UserRemoteDataSource>'), true);
      });

      test('should have correct imports', () {
        createInjectionContainerFile('product');

        final file = File('lib/features/product/inject_product.dart');
        final content = file.readAsStringSync();
        expect(content.contains("import '../../injection_container.dart'"), true);
        expect(content.contains("import 'data/data_sources/remote/product_remote_data_source.dart'"), true);
        expect(content.contains("import 'data/repositories/product_repository_impl.dart'"), true);
        expect(content.contains("import 'domain/repositories/product_repository.dart'"), true);
        expect(content.contains("import 'domain/use_cases/product_use_case.dart'"), true);
      });

      test('should register all dependencies', () {
        createInjectionContainerFile('auth');

        final file = File('lib/features/auth/inject_auth.dart');
        final content = file.readAsStringSync();
        expect(content.contains('Repository'), true);
        expect(content.contains('UseCases'), true);
        expect(content.contains('DataSources'), true);
      });
    });

    group('createCleanArchitectureFiles() Integration', () {
      test('should create complete clean architecture structure', () async {
        await createCleanArchitectureFiles('user');

        // Verify data layer
        expect(File('lib/features/user/data/data_sources/local/user_local_data_source.dart').existsSync(), true);
        expect(File('lib/features/user/data/data_sources/remote/user_remote_data_source.dart').existsSync(), true);
        expect(File('lib/features/user/data/models/user_model.dart').existsSync(), true);
        expect(File('lib/features/user/data/repositories/user_repository_impl.dart').existsSync(), true);

        // Verify domain layer
        expect(File('lib/features/user/domain/entities/user.dart').existsSync(), true);
        expect(File('lib/features/user/domain/repositories/user_repository.dart').existsSync(), true);
        expect(File('lib/features/user/domain/use_cases/user_use_case.dart').existsSync(), true);

        // Verify presentation layer
        expect(File('lib/features/user/presentation/screens/user_screen.dart').existsSync(), true);

        // Verify injection container
        expect(File('lib/features/user/inject_user.dart').existsSync(), true);
      });

      test('should track files created', () async {
        FileCreator.resetFilesCreated();
        await createCleanArchitectureFiles('test_feature');

        expect(FileCreator.getFilesCreated(), greaterThan(0));
      });

      test('should work in dry-run mode', () async {
        FileCreator.setDryRun(true);
        FileCreator.resetFilesCreated();

        await createCleanArchitectureFiles('dry_test');

        expect(FileCreator.getFilesCreated(), greaterThan(0));
        expect(File('lib/features/dry_test/domain/entities/dry_test.dart').existsSync(), false);
      });
    });

    group('File Content Validation', () {
      test('should generate syntactically correct Dart files', () {
        createDirectories('user');
        createDataFiles('user');
        createDomainFiles('user');
        createPresentationFiles('user');
        createInjectionContainerFile('user');

        // Check for common syntax issues
        final files = [
          'lib/features/user/data/data_sources/local/user_local_data_source.dart',
          'lib/features/user/data/data_sources/remote/user_remote_data_source.dart',
          'lib/features/user/data/models/user_model.dart',
          'lib/features/user/data/repositories/user_repository_impl.dart',
          'lib/features/user/domain/entities/user.dart',
          'lib/features/user/domain/repositories/user_repository.dart',
          'lib/features/user/domain/use_cases/user_use_case.dart',
          'lib/features/user/presentation/screens/user_screen.dart',
          'lib/features/user/inject_user.dart',
        ];

        for (final filePath in files) {
          final file = File(filePath);
          expect(file.existsSync(), true, reason: '$filePath should exist');

          final content = file.readAsStringSync();
          // Check for basic Dart syntax elements
          expect(content.isNotEmpty, true, reason: '$filePath should not be empty');
          
          // Check for balanced braces
          final openBraces = '{'.allMatches(content).length;
          final closeBraces = '}'.allMatches(content).length;
          expect(openBraces, closeBraces, reason: '$filePath should have balanced braces');
        }
      });

      test('should generate files with proper imports', () {
        createDirectories('auth');
        createDataFiles('auth');

        final repoFile = File('lib/features/auth/data/repositories/auth_repository_impl.dart');
        final content = repoFile.readAsStringSync();

        expect(content.contains('import'), true);
        expect(content.contains("import 'package:dartz/dartz.dart'"), true);
        expect(content.contains("import '../../domain/repositories/auth_repository.dart'"), true);
      });
    });

    group('Multiple Features', () {
      test('should create multiple features without conflicts', () async {
        await createCleanArchitectureFiles('user');
        await createCleanArchitectureFiles('product');
        await createCleanArchitectureFiles('order');

        expect(Directory('lib/features/user').existsSync(), true);
        expect(Directory('lib/features/product').existsSync(), true);
        expect(Directory('lib/features/order').existsSync(), true);

        expect(File('lib/features/user/domain/entities/user.dart').existsSync(), true);
        expect(File('lib/features/product/domain/entities/product.dart').existsSync(), true);
        expect(File('lib/features/order/domain/entities/order.dart').existsSync(), true);
      });
    });

    group('Edge Cases', () {
      test('should handle single character feature name', () {
        createDirectories('a');
        createDomainFiles('a');

        expect(Directory('lib/features/a/domain').existsSync(), true);
        expect(File('lib/features/a/domain/entities/a.dart').existsSync(), true);
      });

      test('should handle feature names with numbers', () {
        createDirectories('feature123');
        createDomainFiles('feature123');

        expect(Directory('lib/features/feature123/domain').existsSync(), true);
        expect(File('lib/features/feature123/domain/entities/feature123.dart').existsSync(), true);
      });

      test('should handle feature names with underscores', () {
        createDirectories('my_feature_name');
        createDomainFiles('my_feature_name');

        expect(Directory('lib/features/my_feature_name/domain').existsSync(), true);
        expect(File('lib/features/my_feature_name/domain/entities/my_feature_name.dart').existsSync(), true);
      });
    });

    group('createInitParamsFile()', () {
      test('should not throw when called', () {
        // This function is currently a no-op but should not throw
        expect(() => createInitParamsFile('user'), returnsNormally);
      });

      test('should handle different feature names', () {
        expect(() => createInitParamsFile('auth'), returnsNormally);
        expect(() => createInitParamsFile('product'), returnsNormally);
        expect(() => createInitParamsFile('UserProfile'), returnsNormally);
      });
    });
  });
}

