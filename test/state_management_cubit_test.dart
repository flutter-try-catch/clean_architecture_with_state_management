import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_cubit.dart' as cubit;
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

void main() {
  group('Cubit State Management Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_cubit_');
      Directory.current = tempDir.path;
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
      
      // Create base structure first
      createDirectories('user');
      createDomainFiles('user');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
    });

    group('addCubitFiles()', () {
      test('should create cubit directory', () {
        cubit.addCubitFiles('user');

        expect(Directory('lib/features/user/presentation/cubit').existsSync(), true);
      });

      test('should create cubit file', () {
        cubit.addCubitFiles('user');

        final file = File('lib/features/user/presentation/cubit/user_cubit.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserCubit extends Cubit<UserState>'), true);
        expect(content.contains('final UserUseCase userUseCase'), true);
        expect(content.contains('Future<void> fetchData() async'), true);
      });

      test('should create state file', () {
        cubit.addCubitFiles('user');

        final file = File('lib/features/user/presentation/cubit/user_state.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('enum UserStatus'), true);
        expect(content.contains('initial'), true);
        expect(content.contains('loading'), true);
        expect(content.contains('loaded'), true);
        expect(content.contains('error'), true);
        expect(content.contains('class UserState'), true);
        expect(content.contains('copyWith'), true);
      });

      test('should create screen with BlocProvider for Cubit', () {
        cubit.addCubitFiles('user');

        final file = File('lib/features/user/presentation/screens/user_screen.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('import \'package:flutter_bloc/flutter_bloc.dart\''), true);
        expect(content.contains('BlocProvider'), true);
        expect(content.contains('BlocBuilder<UserCubit, UserState>'), true);
        expect(content.contains('getIt<UserCubit>()'), true);
      });

      test('should have status-based state checking', () {
        cubit.addCubitFiles('product');

        final screenFile = File('lib/features/product/presentation/screens/product_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('if (state.status == ProductStatus.loading)'), true);
        expect(content.contains('if (state.status == ProductStatus.error)'), true);
        expect(content.contains('if (state.status == ProductStatus.loaded)'), true);
      });

      test('should emit states using copyWith', () {
        cubit.addCubitFiles('auth');

        final cubitFile = File('lib/features/auth/presentation/cubit/auth_cubit.dart');
        final content = cubitFile.readAsStringSync();
        
        expect(content.contains('emit(state.copyWith(status: AuthStatus.loading))'), true);
        expect(content.contains('emit('), true);
        expect(content.contains('copyWith'), true);
      });

      test('should include errorMessage in state', () {
        cubit.addCubitFiles('payment');

        final stateFile = File('lib/features/payment/presentation/cubit/payment_state.dart');
        final stateContent = stateFile.readAsStringSync();
        
        final cubitFile = File('lib/features/payment/presentation/cubit/payment_cubit.dart');
        final cubitContent = cubitFile.readAsStringSync();
        
        expect(stateContent.contains('final String? errorMessage'), true);
        expect(cubitContent.contains('errorMessage: exception.toString()'), true);
      });

      test('should initialize with initial status', () {
        cubit.addCubitFiles('order');

        final cubitFile = File('lib/features/order/presentation/cubit/order_cubit.dart');
        final content = cubitFile.readAsStringSync();
        
        expect(content.contains('super(const OrderState(status: OrderStatus.initial))'), true);
      });

      test('should include route name in screen', () {
        cubit.addCubitFiles('profile');

        final screenFile = File('lib/features/profile/presentation/screens/profile_screen.dart');
        final content = screenFile.readAsStringSync();
        expect(content.contains('static const routeName = "/profile"'), true);
      });

      test('should have CircularProgressIndicator for loading', () {
        cubit.addCubitFiles('settings');

        final screenFile = File('lib/features/settings/presentation/screens/settings_screen.dart');
        final content = screenFile.readAsStringSync();
        expect(content.contains('CircularProgressIndicator'), true);
      });

      test('should display error message', () {
        cubit.addCubitFiles('cart');

        final screenFile = File('lib/features/cart/presentation/screens/cart_screen.dart');
        final content = screenFile.readAsStringSync();
        expect(content.contains('Text(state.errorMessage'), true);
      });

      test('should have all four status enum values', () {
        cubit.addCubitFiles('notification');

        final stateFile = File('lib/features/notification/presentation/cubit/notification_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('enum NotificationStatus'), true);
        final initialCount = 'initial'.allMatches(content).length;
        final loadingCount = 'loading'.allMatches(content).length;
        final loadedCount = 'loaded'.allMatches(content).length;
        final errorCount = 'error'.allMatches(content).length;
        
        expect(initialCount, greaterThan(0));
        expect(loadingCount, greaterThan(0));
        expect(loadedCount, greaterThan(0));
        expect(errorCount, greaterThan(0));
      });
    });

    group('createInjectionContainerFile() for Cubit', () {
      test('should create injection file with cubit registration', () {
        cubit.addCubitFiles('user');
        cubit.createInjectionContainerFile('user');

        final file = File('lib/features/user/inject_user.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('injectUser()'), true);
        expect(content.contains('getIt.registerFactory(() => UserCubit'), true);
        expect(content.contains('userUseCase: getIt()'), true);
      });

      test('should import cubit file', () {
        cubit.addCubitFiles('product');
        cubit.createInjectionContainerFile('product');

        final file = File('lib/features/product/inject_product.dart');
        final content = file.readAsStringSync();
        expect(content.contains("import 'presentation/cubit/product_cubit.dart'"), true);
      });

      test('should register cubit as factory', () {
        cubit.addCubitFiles('auth');
        cubit.createInjectionContainerFile('auth');

        final file = File('lib/features/auth/inject_auth.dart');
        final content = file.readAsStringSync();
        expect(content.contains('registerFactory'), true);
        expect(content.contains('AuthCubit'), true);
      });

      test('should have comment about cubit', () {
        cubit.addCubitFiles('order');
        cubit.createInjectionContainerFile('order');

        final file = File('lib/features/order/inject_order.dart');
        final content = file.readAsStringSync();
        expect(content.contains('// cubit'), true);
      });
    });

    group('Cubit File Structure', () {
      test('should create both cubit files', () {
        cubit.addCubitFiles('dashboard');

        final cubitDir = Directory('lib/features/dashboard/presentation/cubit');
        expect(cubitDir.existsSync(), true);

        expect(File('lib/features/dashboard/presentation/cubit/dashboard_cubit.dart').existsSync(), true);
        expect(File('lib/features/dashboard/presentation/cubit/dashboard_state.dart').existsSync(), true);
      });

      test('should handle complex feature names', () {
        cubit.addCubitFiles('UserProfile');

        expect(Directory('lib/features/_user_profile/presentation/cubit').existsSync(), true);
        expect(File('lib/features/_user_profile/presentation/cubit/_user_profile_cubit.dart').existsSync(), true);
      });
    });

    group('Cubit Content Validation', () {
      test('should have correct imports in cubit file', () {
        cubit.addCubitFiles('search');

        final cubitFile = File('lib/features/search/presentation/cubit/search_cubit.dart');
        final content = cubitFile.readAsStringSync();
        
        expect(content.contains("import '../../domain/use_cases/search_use_case.dart'"), true);
        expect(content.contains("import 'package:flutter_bloc/flutter_bloc.dart'"), true);
        expect(content.contains("import 'search_state.dart'"), true);
      });

      test('should use result.fold for Either', () {
        cubit.addCubitFiles('feed');

        final cubitFile = File('lib/features/feed/presentation/cubit/feed_cubit.dart');
        final content = cubitFile.readAsStringSync();
        
        expect(content.contains('result.fold('), true);
      });

      test('should have state class with copyWith', () {
        cubit.addCubitFiles('favorite');

        final stateFile = File('lib/features/favorite/presentation/cubit/favorite_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('FavoriteState copyWith('), true);
        expect(content.contains('status: status ?? this.status'), true);
      });

      test('should handle error state properly', () {
        cubit.addCubitFiles('checkout');

        final cubitFile = File('lib/features/checkout/presentation/cubit/checkout_cubit.dart');
        final content = cubitFile.readAsStringSync();
        
        expect(content.contains('status: CheckoutStatus.error'), true);
        expect(content.contains('errorMessage: exception.toString()'), true);
      });
    });

    group('Multiple Cubits', () {
      test('should create multiple cubit features independently', () {
        cubit.addCubitFiles('user');
        cubit.addCubitFiles('product');
        cubit.addCubitFiles('order');

        expect(File('lib/features/user/presentation/cubit/user_cubit.dart').existsSync(), true);
        expect(File('lib/features/product/presentation/cubit/product_cubit.dart').existsSync(), true);
        expect(File('lib/features/order/presentation/cubit/order_cubit.dart').existsSync(), true);
      });
    });

    group('Edge Cases', () {
      test('should handle single character feature names', () {
        cubit.addCubitFiles('a');

        expect(Directory('lib/features/a/presentation/cubit').existsSync(), true);
        expect(File('lib/features/a/presentation/cubit/a_cubit.dart').existsSync(), true);
      });

      test('should handle feature names with numbers', () {
        cubit.addCubitFiles('feature123');

        expect(File('lib/features/feature123/presentation/cubit/feature123_cubit.dart').existsSync(), true);
      });

      test('should handle feature names with underscores', () {
        cubit.addCubitFiles('my_feature');

        expect(File('lib/features/my_feature/presentation/cubit/my_feature_cubit.dart').existsSync(), true);
      });
    });

    group('Screen State Handling', () {
      test('should have initState in screen', () {
        cubit.addCubitFiles('activity');

        final screenFile = File('lib/features/activity/presentation/screens/activity_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('@override'), true);
        expect(content.contains('void initState()'), true);
      });

      test('should show loading UI', () {
        cubit.addCubitFiles('history');

        final screenFile = File('lib/features/history/presentation/screens/history_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Center(child: CircularProgressIndicator())'), true);
      });

      test('should show error UI', () {
        cubit.addCubitFiles('report');

        final screenFile = File('lib/features/report/presentation/screens/report_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Center('), true);
        expect(content.contains('Text(state.errorMessage'), true);
      });

      test('should show loaded UI', () {
        cubit.addCubitFiles('analytics');

        final screenFile = File('lib/features/analytics/presentation/screens/analytics_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Center(child: Text(\'Data Loaded\'))'), true);
      });

      test('should have default UI for initial state', () {
        cubit.addCubitFiles('welcome');

        final screenFile = File('lib/features/welcome/presentation/screens/welcome_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Center('), true);
        expect(content.contains('Text(\'welcome screen\')'), true);
      });
    });
  });
}

