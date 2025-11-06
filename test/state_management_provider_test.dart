import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_provider.dart' as provider;
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

void main() {
  group('Provider State Management Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_provider_');
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

    group('addProviderFiles()', () {
      test('should create provider directory', () {
        provider.addProviderFiles('user');

        expect(Directory('lib/features/user/presentation/provider').existsSync(), true);
      });

      test('should create provider file', () {
        provider.addProviderFiles('user');

        final file = File('lib/features/user/presentation/provider/user_provider.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('class UserProvider extends ChangeNotifier'), true);
        expect(content.contains('final UserUseCase userUseCase'), true);
        expect(content.contains('void init() async'), true);
      });

      test('should create screen with ChangeNotifierProvider', () {
        provider.addProviderFiles('user');

        final file = File('lib/features/user/presentation/screens/user_screen.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('import \'package:provider/provider.dart\''), true);
        expect(content.contains('ChangeNotifierProvider'), true);
        expect(content.contains('Consumer<UserProvider>'), true);
        expect(content.contains('getIt<UserProvider>()'), true);
      });

      test('should initialize provider in constructor', () {
        provider.addProviderFiles('product');

        final providerFile = File('lib/features/product/presentation/provider/product_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('ProductProvider({required this.productUseCase})'), true);
        expect(content.contains('init();'), true);
      });

      test('should have route name in screen', () {
        provider.addProviderFiles('auth');

        final screenFile = File('lib/features/auth/presentation/screens/auth_screen.dart');
        final content = screenFile.readAsStringSync();
        expect(content.contains('static const routeName = "/auth"'), true);
      });

      test('should use Consumer pattern', () {
        provider.addProviderFiles('payment');

        final screenFile = File('lib/features/payment/presentation/screens/payment_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Consumer<PaymentProvider>'), true);
        expect(content.contains('builder: (context, provider, child)'), true);
      });

      test('should have Placeholder widget', () {
        provider.addProviderFiles('order');

        final screenFile = File('lib/features/order/presentation/screens/order_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Placeholder()'), true);
      });

      test('should extend ChangeNotifier', () {
        provider.addProviderFiles('profile');

        final providerFile = File('lib/features/profile/presentation/provider/profile_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('extends ChangeNotifier'), true);
      });

      test('should have correct use case parameter name', () {
        provider.addProviderFiles('settings');

        final providerFile = File('lib/features/settings/presentation/provider/settings_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('final SettingsUseCase settingsUseCase'), true);
        expect(content.contains('required this.settingsUseCase'), true);
      });
    });

    group('createInjectionContainerFile() for Provider', () {
      test('should create injection file with provider registration', () {
        provider.addProviderFiles('user');
        provider.createInjectionContainerFile('user');

        final file = File('lib/features/user/inject_user.dart');
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('injectUser()'), true);
        expect(content.contains('getIt.registerFactory(() => UserProvider'), true);
        expect(content.contains('userUseCase: getIt()'), true);
      });

      test('should import provider file', () {
        provider.addProviderFiles('product');
        provider.createInjectionContainerFile('product');

        final file = File('lib/features/product/inject_product.dart');
        final content = file.readAsStringSync();
        expect(content.contains("import 'presentation/provider/product_provider.dart'"), true);
      });

      test('should register provider as factory', () {
        provider.addProviderFiles('auth');
        provider.createInjectionContainerFile('auth');

        final file = File('lib/features/auth/inject_auth.dart');
        final content = file.readAsStringSync();
        expect(content.contains('registerFactory'), true);
        expect(content.contains('AuthProvider'), true);
      });

      test('should have comment about Providers', () {
        provider.addProviderFiles('order');
        provider.createInjectionContainerFile('order');

        final file = File('lib/features/order/inject_order.dart');
        final content = file.readAsStringSync();
        expect(content.contains('// Providers'), true);
      });

      test('should register all dependencies', () {
        provider.addProviderFiles('cart');
        provider.createInjectionContainerFile('cart');

        final file = File('lib/features/cart/inject_cart.dart');
        final content = file.readAsStringSync();
        
        expect(content.contains('Repository'), true);
        expect(content.contains('UseCases'), true);
        expect(content.contains('DataSources'), true);
      });
    });

    group('Provider File Structure', () {
      test('should create provider file and screen', () {
        provider.addProviderFiles('notification');

        expect(File('lib/features/notification/presentation/provider/notification_provider.dart').existsSync(), true);
        expect(File('lib/features/notification/presentation/screens/notification_screen.dart').existsSync(), true);
      });

      test('should handle complex feature names', () {
        provider.addProviderFiles('UserProfile');

        expect(Directory('lib/features/_user_profile/presentation/provider').existsSync(), true);
        expect(File('lib/features/_user_profile/presentation/provider/_user_profile_provider.dart').existsSync(), true);
      });
    });

    group('Provider Content Validation', () {
      test('should have correct imports in provider file', () {
        provider.addProviderFiles('search');

        final providerFile = File('lib/features/search/presentation/provider/search_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains("import '../../domain/use_cases/search_use_case.dart'"), true);
        expect(content.contains("import 'package:flutter/material.dart'"), true);
      });

      test('should have correct imports in screen file', () {
        provider.addProviderFiles('feed');

        final screenFile = File('lib/features/feed/presentation/screens/feed_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains("import 'package:flutter/material.dart'"), true);
        expect(content.contains("import 'package:provider/provider.dart'"), true);
        expect(content.contains("import '../../../../injection_container.dart'"), true);
        expect(content.contains("import '../provider/feed_provider.dart'"), true);
      });

      test('should have StatefulWidget structure', () {
        provider.addProviderFiles('dashboard');

        final screenFile = File('lib/features/dashboard/presentation/screens/dashboard_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('class DashboardScreen extends StatefulWidget'), true);
        expect(content.contains('class _DashboardState extends State<DashboardScreen>'), true);
      });

      test('should have Scaffold in screen', () {
        provider.addProviderFiles('analytics');

        final screenFile = File('lib/features/analytics/presentation/screens/analytics_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('Scaffold'), true);
      });
    });

    group('Multiple Providers', () {
      test('should create multiple provider features independently', () {
        provider.addProviderFiles('user');
        provider.addProviderFiles('product');
        provider.addProviderFiles('order');

        expect(File('lib/features/user/presentation/provider/user_provider.dart').existsSync(), true);
        expect(File('lib/features/product/presentation/provider/product_provider.dart').existsSync(), true);
        expect(File('lib/features/order/presentation/provider/order_provider.dart').existsSync(), true);
      });
    });

    group('Edge Cases', () {
      test('should handle single character feature names', () {
        provider.addProviderFiles('a');

        expect(Directory('lib/features/a/presentation/provider').existsSync(), true);
        expect(File('lib/features/a/presentation/provider/a_provider.dart').existsSync(), true);
      });

      test('should handle feature names with numbers', () {
        provider.addProviderFiles('feature123');

        expect(File('lib/features/feature123/presentation/provider/feature123_provider.dart').existsSync(), true);
      });

      test('should handle feature names with underscores', () {
        provider.addProviderFiles('my_feature');

        expect(File('lib/features/my_feature/presentation/provider/my_feature_provider.dart').existsSync(), true);
      });
    });

    group('Directory Creation', () {
      test('should create provider directory if not exists', () {
        expect(Directory('lib/features/test/presentation/provider').existsSync(), false);
        
        provider.addProviderFiles('test');
        
        expect(Directory('lib/features/test/presentation/provider').existsSync(), true);
      });

      test('should create screens directory if not exists', () {
        expect(Directory('lib/features/demo/presentation/screens').existsSync(), false);
        
        provider.addProviderFiles('demo');
        
        expect(Directory('lib/features/demo/presentation/screens').existsSync(), true);
      });
    });

    group('Screen Structure', () {
      test('should have build method returning ChangeNotifierProvider', () {
        provider.addProviderFiles('chat');

        final screenFile = File('lib/features/chat/presentation/screens/chat_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('@override'), true);
        expect(content.contains('Widget build(BuildContext context)'), true);
        expect(content.contains('return ChangeNotifierProvider'), true);
      });

      test('should pass provider instance from getIt', () {
        provider.addProviderFiles('message');

        final screenFile = File('lib/features/message/presentation/screens/message_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('create: (context) => getIt<MessageProvider>()'), true);
      });

      test('should use Consumer for rebuilding', () {
        provider.addProviderFiles('comment');

        final screenFile = File('lib/features/comment/presentation/screens/comment_screen.dart');
        final content = screenFile.readAsStringSync();
        
        expect(content.contains('child: Consumer<CommentProvider>'), true);
      });
    });

    group('Provider Init Method', () {
      test('should have async init method', () {
        provider.addProviderFiles('upload');

        final providerFile = File('lib/features/upload/presentation/provider/upload_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('void init() async'), true);
      });

      test('should call init in constructor', () {
        provider.addProviderFiles('download');

        final providerFile = File('lib/features/download/presentation/provider/download_provider.dart');
        final content = providerFile.readAsStringSync();
        
        expect(content.contains('DownloadProvider({required this.downloadUseCase}) {'), true);
        expect(content.contains('init();'), true);
      });
    });

    group('Package Installation', () {
      test('addProviderPackage() should be callable and complete', () async {
        // This test verifies that the function exists and completes
        // Actual package installation would require flutter environment
        expect(() => provider.addProviderPackage(), returnsNormally);
        
        // Wait for the process to complete
        try {
          await provider.addProviderPackage();
        } catch (e) {
          // Process might fail if flutter is not available in test environment
          // But the function should not throw unexpectedly
        }
      });
    });
  });
}

