import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_bloc.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_cubit.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_provider.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture_riverpod.dart';
import 'package:clean_architecture_with_state_management/src/create_clean_architecture.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';

/// Tests for the main public API functions
/// These are the primary entry points that users call
void main() {
  group('Main API Functions', () {
    late Directory tempDir;
    late Directory originalDir;

    setUp(() {
      originalDir = Directory.current;
      tempDir = Directory.systemTemp.createTempSync('test_main_api_');
      Directory.current = tempDir;
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);

      // Create base structure
      createDirectories('user');
      createDomainFiles('user');

      // Create minimal pubspec.yaml for package installation
      final pubspecFile = File('${tempDir.path}/pubspec.yaml');
      pubspecFile.writeAsStringSync('''
name: test_project
description: A test Flutter project
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  dartz: ^0.10.1
  get_it: ^7.6.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
''');

      // Create minimal Flutter project structure
      Directory('${tempDir.path}/lib').createSync();
      File('${tempDir.path}/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(home: Scaffold()));
''');
    });

    tearDown(() {
      Directory.current = originalDir;
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      FileCreator.resetFilesCreated();
    });

    test('createCleanArchitectureBlocFiles should create all bloc files', () async {
      await createCleanArchitectureBlocFiles('user');

      // Verify bloc files were created
      expect(File('lib/features/user/presentation/bloc/user_bloc.dart').existsSync(), true);
      expect(File('lib/features/user/presentation/bloc/user_event.dart').existsSync(), true);
      expect(File('lib/features/user/presentation/bloc/user_state.dart').existsSync(), true);
      expect(File('lib/features/user/presentation/screens/user_screen.dart').existsSync(), true);
      expect(File('lib/features/user/inject_user.dart').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('createCleanArchitectureCubitFiles should create all cubit files', () async {
      // Create base structure first
      createDirectories('product');
      createDomainFiles('product');
      
      await createCleanArchitectureCubitFiles('product');

      // Verify cubit files were created
      expect(File('lib/features/product/presentation/cubit/product_cubit.dart').existsSync(), true);
      expect(File('lib/features/product/presentation/cubit/product_state.dart').existsSync(), true);
      expect(File('lib/features/product/presentation/screens/product_screen.dart').existsSync(), true);
      expect(File('lib/features/product/inject_product.dart').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('createCleanArchitectureProviderFiles should create all provider files', () async {
      // Create base structure first
      createDirectories('order');
      createDomainFiles('order');
      
      await createCleanArchitectureProviderFiles('order');

      // Verify provider files were created
      expect(File('lib/features/order/presentation/provider/order_provider.dart').existsSync(), true);
      expect(File('lib/features/order/presentation/screens/order_screen.dart').existsSync(), true);
      expect(File('lib/features/order/inject_order.dart').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('createCleanArchitectureRiverpodFiles should create all riverpod files', () async {
      // Create base structure first
      createDirectories('auth');
      createDomainFiles('auth');
      
      await createCleanArchitectureRiverpodFiles('auth');

      // Verify riverpod files were created
      expect(File('lib/features/auth/presentation/provider/auth_provider.dart').existsSync(), true);
      expect(File('lib/features/auth/presentation/provider/auth_state.dart').existsSync(), true);
      expect(File('lib/features/auth/presentation/screens/auth_screen.dart').existsSync(), true);
      expect(File('lib/features/auth/inject_auth.dart').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));
  });

  group('Main API Functions - Different Feature Names', () {
    late Directory tempDir;
    late Directory originalDir;

    setUp(() {
      originalDir = Directory.current;
      tempDir = Directory.systemTemp.createTempSync('test_main_api_names_');
      Directory.current = tempDir;
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);

      // Create minimal pubspec.yaml
      final pubspecFile = File('${tempDir.path}/pubspec.yaml');
      pubspecFile.writeAsStringSync('''
name: test_project
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  dartz: ^0.10.1
  get_it: ^7.6.0

dev_dependencies:
  flutter_test:
    sdk: flutter
''');

      Directory('${tempDir.path}/lib').createSync();
      File('${tempDir.path}/lib/main.dart').writeAsStringSync('void main() {}');
    });

    tearDown(() {
      Directory.current = originalDir;
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      FileCreator.resetFilesCreated();
    });

    test('bloc API with camelCase feature name', () async {
      createDirectories('userProfile');
      createDomainFiles('userProfile');
      createDataFiles('userProfile');
      
      await createCleanArchitectureBlocFiles('userProfile');
      
      expect(Directory('lib/features/user_profile/presentation/bloc').existsSync(), true);
      expect(File('lib/features/user_profile/presentation/bloc/user_profile_bloc.dart').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('cubit API with snake_case feature name', () async {
      createDirectories('user_auth');
      createDomainFiles('user_auth');
      
      await createCleanArchitectureCubitFiles('user_auth');
      
      expect(Directory('lib/features/user_auth/presentation/cubit').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('provider API with single character name', () async {
      createDirectories('a');
      createDomainFiles('a');
      
      await createCleanArchitectureProviderFiles('a');
      
      expect(Directory('lib/features/a/presentation/provider').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('riverpod API with numbers in name', () async {
      createDirectories('product2');
      createDomainFiles('product2');
      
      await createCleanArchitectureRiverpodFiles('product2');
      
      expect(Directory('lib/features/product2/presentation/provider').existsSync(), true);
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}

