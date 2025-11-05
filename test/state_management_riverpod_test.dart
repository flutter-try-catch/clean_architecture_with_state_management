import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_riverpod.dart' as riverpod;
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

void main() {
  group('Riverpod State Management Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_riverpod_');
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

    group('addProviderFiles() for Riverpod', () {
      test('should create provider directory', () {
        riverpod.addProviderFiles('user');

        expect(Directory('lib/features/user/presentation/provider').existsSync(), true);
      });

      test('should create state file', () {
        riverpod.addProviderFiles('user');

        final file = File('lib/features/user/presentation/provider/user_state.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('abstract class UserState'), true);
        expect(content.contains('class UserInitial extends UserState'), true);
        expect(content.contains('class UserLoading extends UserState'), true);
        expect(content.contains('class UserLoaded extends UserState'), true);
        expect(content.contains('class UserError extends UserState'), true);
      });

      test('should create provider file', () {
        riverpod.addProviderFiles('user');

        final file = File('lib/features/user/presentation/provider/user_provider.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('final userProvider = StateNotifierProvider<UserProvider, UserState>'), true);
        expect(content.contains('class UserProvider extends StateNotifier<UserState>'), true);
        expect(content.contains('final UserUseCase userUseCase'), true);
      });

      test('should create screen with ConsumerWidget', () {
        riverpod.addProviderFiles('user');

        final file = File('lib/features/user/presentation/screens/user_screen.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('import \'package:flutter_riverpod/flutter_riverpod.dart\''), true);
        expect(content.contains('class UserScreen extends ConsumerWidget'), true);
        expect(content.contains('Widget build(BuildContext context, WidgetRef ref)'), true);
        expect(content.contains('final state = ref.watch(userProvider)'), true);
      });

      test('should have state error with exception', () {
        riverpod.addProviderFiles('product');

        final stateFile = File('lib/features/product/presentation/provider/product_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('class ProductError extends ProductState'), true);
        expect(content.contains('final Exception exception'), true);
        expect(content.contains('ProductError({required this.exception})'), true);
      });

      test('should initialize with Initial state', () {
        riverpod.addProviderFiles('auth');

        final providerFile = File('lib/features/auth/presentation/provider/auth_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('super(AuthInitial())'), true);
      });

      test('should have init method', () {
        riverpod.addProviderFiles('payment');

        final providerFile = File('lib/features/payment/presentation/provider/payment_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('void init() async'), true);
      });

      test('should call init in constructor', () {
        riverpod.addProviderFiles('order');

        final providerFile = File('lib/features/order/presentation/provider/order_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains(': super(OrderInitial())'), true);
        expect(content.contains('init();'), true);
      });

      test('should have route name in screen', () {
        riverpod.addProviderFiles('profile');

        final screenFile = File('lib/features/profile/presentation/screens/profile_screen.dart');
        final content = screenFile.readAsStringSync();
        expect(content.contains('static const String routeName'), true);
      });

      test('should handle all state types in screen', () {
        riverpod.addProviderFiles('settings');

        final screenFile = File('lib/features/settings/presentation/screens/settings_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('if (state is SettingsInitial)'), true);
        expect(content.contains('if (state is SettingsLoading)'), true);
        expect(content.contains('if (state is SettingsLoaded)'), true);
      });

      test('should use Builder widget', () {
        riverpod.addProviderFiles('cart');

        final screenFile = File('lib/features/cart/presentation/screens/cart_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Builder('), true);
        expect(content.contains('builder: (context)'), true);
      });

      test('should display different text for each state', () {
        riverpod.addProviderFiles('notification');

        final screenFile = File('lib/features/notification/presentation/screens/notification_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Text(\'Initial State\')'), true);
        expect(content.contains('Text(\'Loading State\')'), true);
        expect(content.contains('Text(\'Loaded State\')'), true);
      });
    });

    group('createInjectionContainerFile() for Riverpod', () {
      test('should create injection file with riverpod providers', () {
        riverpod.addProviderFiles('user');
        riverpod.createInjectionContainerFile('user');

        final file = File('lib/features/user/inject_user.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('import \'package:flutter_riverpod/flutter_riverpod.dart\''), true);
        expect(content.contains('final userProvider ='), true);
        expect(content.contains('StateNotifierProvider<UserProvider, UserState>'), true);
      });

      test('should define all providers', () {
        riverpod.addProviderFiles('product');
        riverpod.createInjectionContainerFile('product');

        final file = File('lib/features/product/inject_product.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('// Providers'), true);
        expect(content.contains('// Repository'), true);
        expect(content.contains('// UseCases'), true);
        expect(content.contains('// DataSources'), true);
      });

      test('should use Provider for repository', () {
        riverpod.addProviderFiles('auth');
        riverpod.createInjectionContainerFile('auth');

        final file = File('lib/features/auth/inject_auth.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('final authRepositoryProvider = Provider<AuthRepository>'), true);
      });

      test('should use Provider for use cases', () {
        riverpod.addProviderFiles('order');
        riverpod.createInjectionContainerFile('order');

        final file = File('lib/features/order/inject_order.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('final orderUseCaseProvider = Provider<OrderUseCase>'), true);
      });

      test('should use Provider for data sources', () {
        riverpod.addProviderFiles('payment');
        riverpod.createInjectionContainerFile('payment');

        final file = File('lib/features/payment/inject_payment.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('final paymentDataSourceProvider = Provider<PaymentRemoteDataSource>'), true);
      });

      test('should use ref.read and ref.watch', () {
        riverpod.addProviderFiles('cart');
        riverpod.createInjectionContainerFile('cart');

        final file = File('lib/features/cart/inject_cart.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('ref.read'), true);
        expect(content.contains('ref.watch'), true);
      });

      test('should import state and provider files', () {
        riverpod.addProviderFiles('dashboard');
        riverpod.createInjectionContainerFile('dashboard');

        final file = File('lib/features/dashboard/inject_dashboard.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains("import 'presentation/provider/dashboard_provider.dart'"), true);
        expect(content.contains("import 'presentation/provider/dashboard_state.dart'"), true);
      });
    });

    group('Riverpod File Structure', () {
      test('should create provider and state files', () {
        riverpod.addProviderFiles('analytics');

        expect(File('lib/features/analytics/presentation/provider/analytics_provider.dart').existsSync(), true);
        expect(File('lib/features/analytics/presentation/provider/analytics_state.dart').existsSync(), true);
        expect(File('lib/features/analytics/presentation/screens/analytics_screen.dart').existsSync(), true);
      });

      test('should handle complex feature names', () {
        riverpod.addProviderFiles('UserProfile');

        expect(Directory('lib/features/_user_profile/presentation/provider').existsSync(), true);
        expect(File('lib/features/_user_profile/presentation/provider/_user_profile_provider.dart').existsSync(), true);
      });
    });

    group('generateScreenCode()', () {
      test('should generate correct screen code', () {
        final code = riverpod.generateScreenCode('test');
        
        expect(code.contains('class TestScreen extends ConsumerWidget'), true);
        expect(code.contains('Widget build(BuildContext context, WidgetRef ref)'), true);
        expect(code.contains('final state = ref.watch(testProvider)'), true);
        expect(code.contains('if (state is TestInitial)'), true);
        expect(code.contains('if (state is TestLoading)'), true);
        expect(code.contains('if (state is TestLoaded)'), true);
      });

      test('should use lowercase for provider reference', () {
        final code = riverpod.generateScreenCode('UserProfile');
        
        expect(code.contains('ref.watch(userprofileProvider)'), true);
      });

      test('should have Scaffold structure', () {
        final code = riverpod.generateScreenCode('feature');
        
        expect(code.contains('return Scaffold('), true);
        expect(code.contains('body: Center('), true);
      });
    });

    group('Riverpod Content Validation', () {
      test('should have correct imports in provider file', () {
        riverpod.addProviderFiles('search');

        final providerFile = File('lib/features/search/presentation/provider/search_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains("import 'package:flutter_riverpod/flutter_riverpod.dart'"), true);
        expect(content.contains("import '../../domain/use_cases/search_use_case.dart'"), true);
        expect(content.contains("import 'search_state.dart'"), true);
        expect(content.contains("import '../../inject_search.dart'"), true);
      });

      test('should have correct imports in screen file', () {
        riverpod.addProviderFiles('feed');

        final screenFile = File('lib/features/feed/presentation/screens/feed_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains("import 'package:flutter/material.dart'"), true);
        expect(content.contains("import 'package:flutter_riverpod/flutter_riverpod.dart'"), true);
        expect(content.contains("import '../provider/feed_provider.dart'"), true);
        expect(content.contains("import '../provider/feed_state.dart'"), true);
      });

      test('should use StateNotifier', () {
        riverpod.addProviderFiles('comment');

        final providerFile = File('lib/features/comment/presentation/provider/comment_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('extends StateNotifier<CommentState>'), true);
      });

      test('should define global provider', () {
        riverpod.addProviderFiles('message');

        final providerFile = File('lib/features/message/presentation/provider/message_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('final messageProvider = StateNotifierProvider'), true);
      });
    });

    group('Multiple Riverpod Features', () {
      test('should create multiple riverpod features independently', () {
        riverpod.addProviderFiles('user');
        riverpod.addProviderFiles('product');
        riverpod.addProviderFiles('order');

        expect(File('lib/features/user/presentation/provider/user_provider.dart').existsSync(), true);
        expect(File('lib/features/product/presentation/provider/product_provider.dart').existsSync(), true);
        expect(File('lib/features/order/presentation/provider/order_provider.dart').existsSync(), true);
      });
    });

    group('Edge Cases', () {
      test('should handle single character feature names', () {
        riverpod.addProviderFiles('a');

        expect(Directory('lib/features/a/presentation/provider').existsSync(), true);
        expect(File('lib/features/a/presentation/provider/a_provider.dart').existsSync(), true);
      });

      test('should handle feature names with numbers', () {
        riverpod.addProviderFiles('feature123');

        expect(File('lib/features/feature123/presentation/provider/feature123_provider.dart').existsSync(), true);
      });

      test('should handle feature names with underscores', () {
        riverpod.addProviderFiles('my_feature');

        expect(File('lib/features/my_feature/presentation/provider/my_feature_provider.dart').existsSync(), true);
      });
    });

    group('Riverpod State Classes', () {
      test('should have abstract base state', () {
        riverpod.addProviderFiles('upload');

        final stateFile = File('lib/features/upload/presentation/provider/upload_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('abstract class UploadState {}'), true);
      });

      test('should have all concrete state classes', () {
        riverpod.addProviderFiles('download');

        final stateFile = File('lib/features/download/presentation/provider/download_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('class DownloadInitial extends DownloadState'), true);
        expect(content.contains('class DownloadLoading extends DownloadState'), true);
        expect(content.contains('class DownloadLoaded extends DownloadState'), true);
        expect(content.contains('class DownloadError extends DownloadState'), true);
      });

      test('should have exception in Error state', () {
        riverpod.addProviderFiles('sync');

        final stateFile = File('lib/features/sync/presentation/provider/sync_state.dart');
        final content = stateFile.readAsStringSync();
        
        expect(content.contains('SyncError({required this.exception})'), true);
      });
    });

    group('Riverpod Provider Definition', () {
      test('should define provider at top level', () {
        riverpod.addProviderFiles('chat');

        final providerFile = File('lib/features/chat/presentation/provider/chat_provider.dart');
        final content = providerFile.readAsStringSync();
        
        final providerDefIndex = content.indexOf('final chatProvider');
        final classDefIndex = content.indexOf('class ChatProvider');
        
        expect(providerDefIndex, lessThan(classDefIndex));
      });

      test('should reference use case provider', () {
        riverpod.addProviderFiles('history');

        final providerFile = File('lib/features/history/presentation/provider/history_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('ref.read(historyUseCaseProvider)'), true);
      });
    });

    group('Screen ConsumerWidget', () {
      test('should extend ConsumerWidget not StatelessWidget', () {
        riverpod.addProviderFiles('report');

        final screenFile = File('lib/features/report/presentation/screens/report_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('extends ConsumerWidget'), true);
        expect(content.contains('extends StatelessWidget'), false);
      });

      test('should have WidgetRef parameter', () {
        riverpod.addProviderFiles('activity');

        final screenFile = File('lib/features/activity/presentation/screens/activity_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Widget build(BuildContext context, WidgetRef ref)'), true);
      });

      test('should use ref.watch to listen to provider', () {
        riverpod.addProviderFiles('log');

        final screenFile = File('lib/features/log/presentation/screens/log_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('ref.watch('), true);
      });
    });
  });
}

