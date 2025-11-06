import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

/// Integration tests that test the full flow
/// These tests cover edge cases and integration scenarios
void main() {
  group('Integration Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_integration_');
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

    group('Full Architecture Creation', () {
      test('should create complete architecture for a feature', () async {
        await createCleanArchitectureFiles('user');

        // Verify directories exist
        expect(Directory('lib/features/user/data').existsSync(), true);
        expect(Directory('lib/features/user/domain').existsSync(), true);
        expect(Directory('lib/features/user/presentation').existsSync(), true);

        // Verify all files were created
        expect(File('lib/features/user/data/data_sources/local/user_local_data_source.dart').existsSync(), true);
        expect(File('lib/features/user/data/data_sources/remote/user_remote_data_source.dart').existsSync(), true);
        expect(File('lib/features/user/data/models/user_model.dart').existsSync(), true);
        expect(File('lib/features/user/data/repositories/user_repository_impl.dart').existsSync(), true);
        expect(File('lib/features/user/domain/entities/user.dart').existsSync(), true);
        expect(File('lib/features/user/domain/repositories/user_repository.dart').existsSync(), true);
        expect(File('lib/features/user/domain/use_cases/user_use_case.dart').existsSync(), true);
        expect(File('lib/features/user/presentation/screens/user_screen.dart').existsSync(), true);
        expect(File('lib/features/user/inject_user.dart').existsSync(), true);
      });

      test('should handle complex feature names', () async {
        await createCleanArchitectureFiles('UserAuthentication');

        expect(Directory('lib/features/_user_authentication').existsSync(), true);
      });

      test('should create files with correct content structure', () async {
        await createCleanArchitectureFiles('product');

        final entityFile = File('lib/features/product/domain/entities/product.dart');
        final content = entityFile.readAsStringSync();
        
        expect(content.contains('class Product'), true);
        expect(content.contains('final String? data'), true);
      });

      test('should create model that extends entity', () async {
        await createCleanArchitectureFiles('order');

        final modelFile = File('lib/features/order/data/models/order_model.dart');
        final content = modelFile.readAsStringSync();
        
        expect(content.contains('class OrderModel extends Order'), true);
        expect(content.contains('fromJson'), true);
        expect(content.contains('toJson'), true);
      });
    });

    group('Repository Pattern', () {
      test('should create repository interface and implementation', () async {
        await createCleanArchitectureFiles('payment');

        final interfaceFile = File('lib/features/payment/domain/repositories/payment_repository.dart');
        final implFile = File('lib/features/payment/data/repositories/payment_repository_impl.dart');
        
        expect(interfaceFile.existsSync(), true);
        expect(implFile.existsSync(), true);

        final interfaceContent = interfaceFile.readAsStringSync();
        final implContent = implFile.readAsStringSync();

        expect(interfaceContent.contains('abstract class PaymentRepository'), true);
        expect(implContent.contains('class PaymentRepositoryImpl implements PaymentRepository'), true);
      });

      test('should inject remote data source into repository', () async {
        await createCleanArchitectureFiles('notification');

        final implFile = File('lib/features/notification/data/repositories/notification_repository_impl.dart');
        final content = implFile.readAsStringSync();

        expect(content.contains('final NotificationRemoteDataSource remoteDataSource'), true);
        expect(content.contains('NotificationRepositoryImpl({required this.remoteDataSource})'), true);
      });
    });

    group('Use Case Pattern', () {
      test('should create use case with repository dependency', () async {
        await createCleanArchitectureFiles('chat');

        final useCaseFile = File('lib/features/chat/domain/use_cases/chat_use_case.dart');
        final content = useCaseFile.readAsStringSync();

        expect(content.contains('class ChatUseCase'), true);
        expect(content.contains('final ChatRepository repository'), true);
        expect(content.contains('Future<Either<Exception, Unit>> call()'), true);
      });

      test('should use Either for error handling', () async {
        await createCleanArchitectureFiles('analytics');

        final repoFile = File('lib/features/analytics/data/repositories/analytics_repository_impl.dart');
        final content = repoFile.readAsStringSync();

        expect(content.contains('Future<Either<Exception, Unit>>'), true);
        expect(content.contains('try {'), true);
        expect(content.contains('return Right('), true);
        expect(content.contains('on Exception catch (exception)'), true);
        expect(content.contains('return Left(exception)'), true);
      });
    });

    group('Dependency Injection', () {
      test('should create injection file with all dependencies', () async {
        await createCleanArchitectureFiles('search');

        final injectFile = File('lib/features/search/inject_search.dart');
        expect(injectFile.existsSync(), true);

        final content = injectFile.readAsStringSync();
        expect(content.contains('injectSearch()'), true);
        expect(content.contains('// Repository'), true);
        expect(content.contains('// UseCases'), true);
        expect(content.contains('// DataSources'), true);
        expect(content.contains('getIt.registerLazySingleton'), true);
      });

      test('should use lazy singleton for repository and use cases', () async {
        await createCleanArchitectureFiles('profile');

        final injectFile = File('lib/features/profile/inject_profile.dart');
        final content = injectFile.readAsStringSync();

        expect(content.contains('getIt.registerLazySingleton<ProfileRepository>'), true);
        expect(content.contains('getIt.registerLazySingleton(() => ProfileUseCase(getIt()))'), true);
      });
    });

    group('Data Sources', () {
      test('should create both local and remote data sources', () async {
        await createCleanArchitectureFiles('settings');

        final localFile = File('lib/features/settings/data/data_sources/local/settings_local_data_source.dart');
        final remoteFile = File('lib/features/settings/data/data_sources/remote/settings_remote_data_source.dart');

        expect(localFile.existsSync(), true);
        expect(remoteFile.existsSync(), true);
      });

      test('should create abstract interface and implementation', () async {
        await createCleanArchitectureFiles('location');

        final remoteFile = File('lib/features/location/data/data_sources/remote/location_remote_data_source.dart');
        final content = remoteFile.readAsStringSync();

        expect(content.contains('abstract class LocationRemoteDataSource'), true);
        expect(content.contains('class LocationRemoteDataSourceImpl implements LocationRemoteDataSource'), true);
      });
    });

    group('Multiple Features', () {
      test('should create multiple features independently', () async {
        await createCleanArchitectureFiles('user');
        await createCleanArchitectureFiles('product');
        await createCleanArchitectureFiles('order');

        expect(Directory('lib/features/user').existsSync(), true);
        expect(Directory('lib/features/product').existsSync(), true);
        expect(Directory('lib/features/order').existsSync(), true);

        expect(File('lib/features/user/inject_user.dart').existsSync(), true);
        expect(File('lib/features/product/inject_product.dart').existsSync(), true);
        expect(File('lib/features/order/inject_order.dart').existsSync(), true);
      });

      test('should not interfere with existing features', () async {
        await createCleanArchitectureFiles('auth');
        
        final authFile = File('lib/features/auth/domain/entities/auth.dart');
        authFile.writeAsStringSync('// Custom content');

        await createCleanArchitectureFiles('profile');

        // Auth file should still have custom content
        expect(authFile.readAsStringSync().contains('// Custom content'), true);
        // Profile should be created
        expect(Directory('lib/features/profile').existsSync(), true);
      });
    });
  });
}

