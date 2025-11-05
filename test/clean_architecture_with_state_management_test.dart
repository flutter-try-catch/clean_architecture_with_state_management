import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/string_extensions.dart';
import 'package:clean_architecture_with_state_management/src/cli_helper.dart';
import 'package:clean_architecture_with_state_management/src/file_creator.dart';
import 'package:clean_architecture_with_state_management/src/init_helper.dart';

void main() {
  group('String Extensions Tests', () {
    test('capitalize() should capitalize first letter', () {
      expect('hello'.capitalize(), 'Hello');
      expect('HELLO'.capitalize(), 'HELLO');
      expect('h'.capitalize(), 'H');
      expect(''.capitalize(), '');
      expect('myFeature'.capitalize(), 'MyFeature');
    });

    test('toLowerCaseFirst() should lowercase first letter', () {
      expect('Hello'.toLowerCaseFirst(), 'hello');
      expect('HELLO'.toLowerCaseFirst(), 'hELLO');
      expect('H'.toLowerCaseFirst(), 'h');
      expect(''.toLowerCaseFirst(), '');
      expect('MyFeature'.toLowerCaseFirst(), 'myFeature');
    });

    test('toSnakeCase() should convert to snake_case', () {
      expect('helloWorld'.toSnakeCase(), 'hello_world');
      expect('HelloWorld'.toSnakeCase(), '_hello_world');
      expect('myFeatureName'.toSnakeCase(), 'my_feature_name');
      expect('MyFeatureName'.toSnakeCase(), '_my_feature_name');
      expect('hello'.toSnakeCase(), 'hello');
      expect('HELLO'.toSnakeCase(), '_h_e_l_l_o');
      expect('hello world'.toSnakeCase(), 'hello_world');
      expect('hello  world'.toSnakeCase(), 'hello_world');
    });

    test('toSnakeCase() should handle multiple spaces', () {
      expect('hello   world'.toSnakeCase(), 'hello_world');
      expect('my  feature  name'.toSnakeCase(), 'my_feature_name');
    });

    test('toSnakeCase() should handle mixed case', () {
      expect('getHTTPResponse'.toSnakeCase(), 'get_h_t_t_p_response');
      expect('HTTPResponse'.toSnakeCase(), '_h_t_t_p_response');
    });
  });

  group('CLIHelper Tests', () {
    group('isValidFeatureName()', () {
      test('should accept valid feature names', () {
        expect(CLIHelper.isValidFeatureName('user'), true);
        expect(CLIHelper.isValidFeatureName('User'), true);
        expect(CLIHelper.isValidFeatureName('myFeature'), true);
        expect(CLIHelper.isValidFeatureName('my_feature'), true);
        expect(CLIHelper.isValidFeatureName('feature123'), true);
        expect(CLIHelper.isValidFeatureName('Feature_123'), true);
        expect(CLIHelper.isValidFeatureName('a'), true);
        expect(CLIHelper.isValidFeatureName('A'), true);
        expect(CLIHelper.isValidFeatureName('auth_service'), true);
        expect(CLIHelper.isValidFeatureName('AuthService'), true);
      });

      test('should reject invalid feature names', () {
        expect(CLIHelper.isValidFeatureName('123feature'), false);
        expect(CLIHelper.isValidFeatureName('_feature'), false);
        expect(CLIHelper.isValidFeatureName('feature-name'), false);
        expect(CLIHelper.isValidFeatureName('feature name'), false);
        expect(CLIHelper.isValidFeatureName('feature!'), false);
        expect(CLIHelper.isValidFeatureName('feature@name'), false);
        expect(CLIHelper.isValidFeatureName(''), false);
        expect(CLIHelper.isValidFeatureName('123'), false);
        expect(CLIHelper.isValidFeatureName('_123'), false);
        expect(CLIHelper.isValidFeatureName('feature.name'), false);
      });

      test('should reject special characters', () {
        expect(CLIHelper.isValidFeatureName('feature#name'), false);
        expect(CLIHelper.isValidFeatureName('feature\$name'), false);
        expect(CLIHelper.isValidFeatureName('feature%name'), false);
        expect(CLIHelper.isValidFeatureName('feature&name'), false);
        expect(CLIHelper.isValidFeatureName('feature*name'), false);
        expect(CLIHelper.isValidFeatureName('feature(name)'), false);
      });
    });
  });

  group('FileCreator Tests', () {
    setUp(() {
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
    });

    tearDown(() {
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(false);
    });

    test('should initialize with zero files created', () {
      expect(FileCreator.getFilesCreated(), 0);
    });

    test('should set and get dry-run mode', () {
      expect(FileCreator.getDryRun(), false);
      
      FileCreator.setDryRun(true);
      expect(FileCreator.getDryRun(), true);
      
      FileCreator.setDryRun(false);
      expect(FileCreator.getDryRun(), false);
    });

    test('should increment files created', () {
      expect(FileCreator.getFilesCreated(), 0);
      
      FileCreator.incrementFilesCreated();
      expect(FileCreator.getFilesCreated(), 1);
      
      FileCreator.incrementFilesCreated();
      expect(FileCreator.getFilesCreated(), 2);
      
      FileCreator.incrementFilesCreated();
      expect(FileCreator.getFilesCreated(), 3);
    });

    test('should reset files created', () {
      FileCreator.incrementFilesCreated();
      FileCreator.incrementFilesCreated();
      expect(FileCreator.getFilesCreated(), 2);
      
      FileCreator.resetFilesCreated();
      expect(FileCreator.getFilesCreated(), 0);
    });

    group('createFile()', () {
      late Directory tempDir;

      setUp(() {
        tempDir = Directory.systemTemp.createTempSync('test_');
      });

      tearDown(() {
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
      });

      test('should create file in dry-run mode without writing', () {
        FileCreator.setDryRun(true);
        final path = '${tempDir.path}/test_file.dart';
        
        FileCreator.createFile(path, 'test content');
        
        expect(FileCreator.getFilesCreated(), 1);
        expect(File(path).existsSync(), false);
      });

      test('should create file when not in dry-run mode', () {
        FileCreator.setDryRun(false);
        final path = '${tempDir.path}/test_file.dart';
        
        FileCreator.createFile(path, 'test content');
        
        expect(FileCreator.getFilesCreated(), 1);
        expect(File(path).existsSync(), true);
        expect(File(path).readAsStringSync(), 'test content');
      });

      test('should skip existing files', () {
        FileCreator.setDryRun(false);
        final path = '${tempDir.path}/existing_file.dart';
        
        // Create file first
        File(path).writeAsStringSync('original content');
        
        // Try to create again
        FileCreator.createFile(path, 'new content');
        
        // Should not increment counter for existing files
        expect(FileCreator.getFilesCreated(), 0);
        expect(File(path).readAsStringSync(), 'original content');
      });

      test('should track multiple files in dry-run', () {
        FileCreator.setDryRun(true);
        
        FileCreator.createFile('${tempDir.path}/file1.dart', 'content1');
        FileCreator.createFile('${tempDir.path}/file2.dart', 'content2');
        FileCreator.createFile('${tempDir.path}/file3.dart', 'content3');
        
        expect(FileCreator.getFilesCreated(), 3);
      });
    });

    group('createDirectory()', () {
      late Directory tempDir;

      setUp(() {
        tempDir = Directory.systemTemp.createTempSync('test_');
      });

      tearDown(() {
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
      });

      test('should create directory when not in dry-run mode', () {
        FileCreator.setDryRun(false);
        final path = '${tempDir.path}/test_dir';
        
        FileCreator.createDirectory(path);
        
        expect(Directory(path).existsSync(), true);
      });

      test('should not create directory in dry-run mode', () {
        FileCreator.setDryRun(true);
        final path = '${tempDir.path}/test_dir';
        
        FileCreator.createDirectory(path);
        
        expect(Directory(path).existsSync(), false);
      });

      test('should create nested directories', () {
        FileCreator.setDryRun(false);
        final path = '${tempDir.path}/level1/level2/level3';
        
        FileCreator.createDirectory(path);
        
        expect(Directory(path).existsSync(), true);
      });
    });
  });

  group('Init Function Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('test_init_');
      Directory.current = tempDir.path;
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('should create injection_container.dart if it does not exist', () async {
      await init('testFeature');
      
      final file = File('lib/injection_container.dart');
      expect(file.existsSync(), true);
      
      final content = file.readAsStringSync();
      expect(content.contains('GetIt'), true);
      expect(content.contains('ServiceLocator'), true);
      expect(content.contains('class ServiceLocator'), true);
    });

    test('should not overwrite existing injection_container.dart', () async {
      final file = File('lib/injection_container.dart');
      file.createSync(recursive: true);
      file.writeAsStringSync('existing content');
      
      await init('testFeature');
      
      expect(file.readAsStringSync(), 'existing content');
    });
  });

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

    test('should handle complex feature names with string extensions', () {
      final featureName = 'UserProfile';
      
      expect(featureName.toSnakeCase(), '_user_profile');
      expect(featureName.capitalize(), 'UserProfile');
      expect(featureName.toLowerCaseFirst(), 'userProfile');
    });

    test('should handle snake_case feature names', () {
      final featureName = 'user_profile';
      
      expect(featureName.toSnakeCase(), 'user_profile');
      expect(featureName.capitalize(), 'User_profile');
      expect(featureName.toLowerCaseFirst(), 'user_profile');
    });
  });

  group('Edge Cases Tests', () {
    test('String extensions with empty strings', () {
      expect(''.capitalize(), '');
      expect(''.toLowerCaseFirst(), '');
      expect(''.toSnakeCase(), '');
    });

    test('String extensions with single character', () {
      expect('a'.capitalize(), 'A');
      expect('A'.toLowerCaseFirst(), 'a');
      expect('A'.toSnakeCase(), '_a');
    });

    test('FileCreator operations in sequence', () {
      FileCreator.resetFilesCreated();
      FileCreator.setDryRun(true);
      
      expect(FileCreator.getFilesCreated(), 0);
      
      FileCreator.incrementFilesCreated();
      FileCreator.incrementFilesCreated();
      expect(FileCreator.getFilesCreated(), 2);
      
      FileCreator.resetFilesCreated();
      expect(FileCreator.getFilesCreated(), 0);
      
      FileCreator.setDryRun(false);
      expect(FileCreator.getDryRun(), false);
    });

    test('CLIHelper validation edge cases', () {
      // Test with unicode characters
      expect(CLIHelper.isValidFeatureName('café'), false);
      expect(CLIHelper.isValidFeatureName('user名前'), false);
      
      // Test with only underscores and numbers after valid start
      expect(CLIHelper.isValidFeatureName('a___'), true);
      expect(CLIHelper.isValidFeatureName('a123'), true);
      expect(CLIHelper.isValidFeatureName('A___123'), true);
    });
  });

  group('Real-world Scenario Tests', () {
    test('should validate common feature names', () {
      final commonFeatures = [
        'authentication',
        'user_profile',
        'product_catalog',
        'shopping_cart',
        'payment',
        'notifications',
        'settings',
        'dashboard',
      ];

      for (final feature in commonFeatures) {
        expect(CLIHelper.isValidFeatureName(feature), true,
            reason: '$feature should be valid');
      }
    });

    test('should reject common invalid patterns', () {
      final invalidFeatures = [
        '1_feature',
        '_private',
        'feature-name',
        'feature.name',
        'feature name',
        '',
      ];

      for (final feature in invalidFeatures) {
        expect(CLIHelper.isValidFeatureName(feature), false,
            reason: '$feature should be invalid');
      }
    });

    test('should convert various naming conventions to snake_case', () {
      final testCases = {
        'UserProfile': '_user_profile',
        'userProfile': 'user_profile',
        'user_profile': 'user_profile',
        'UserProfileManager': '_user_profile_manager',
        'HTTPSConnection': '_h_t_t_p_s_connection',
      };

      testCases.forEach((input, expected) {
        expect(input.toSnakeCase(), expected,
            reason: '$input should convert to $expected');
      });
    });
  });

  group('FileCreator Stress Tests', () {
    test('should handle many file creations in dry-run', () {
      FileCreator.setDryRun(true);
      FileCreator.resetFilesCreated();

      for (int i = 0; i < 100; i++) {
        FileCreator.createFile('test_file_$i.dart', 'content $i');
      }

      expect(FileCreator.getFilesCreated(), 100);
    });

    test('should handle rapid mode switches', () {
      FileCreator.resetFilesCreated();
      
      FileCreator.setDryRun(true);
      expect(FileCreator.getDryRun(), true);
      
      FileCreator.setDryRun(false);
      expect(FileCreator.getDryRun(), false);
      
      FileCreator.setDryRun(true);
      expect(FileCreator.getDryRun(), true);
      
      FileCreator.setDryRun(false);
      expect(FileCreator.getDryRun(), false);
    });
  });

  group('String Extensions Advanced Tests', () {
    test('capitalize with various inputs', () {
      expect('test'.capitalize(), 'Test');
      expect('TEST'.capitalize(), 'TEST');
      expect('tEST'.capitalize(), 'TEST');
      expect('123test'.capitalize(), '123test');
      expect('_test'.capitalize(), '_test');
    });

    test('toLowerCaseFirst with various inputs', () {
      expect('Test'.toLowerCaseFirst(), 'test');
      expect('TEST'.toLowerCaseFirst(), 'tEST');
      expect('tEST'.toLowerCaseFirst(), 'tEST');
      expect('123Test'.toLowerCaseFirst(), '123Test');
      expect('_Test'.toLowerCaseFirst(), '_Test');
    });

    test('toSnakeCase with continuous capitals', () {
      expect('ABC'.toSnakeCase(), '_a_b_c');
      expect('ABCD'.toSnakeCase(), '_a_b_c_d');
      expect('XMLParser'.toSnakeCase(), '_x_m_l_parser');
      expect('parseXML'.toSnakeCase(), 'parse_x_m_l');
    });
  });

  group('Validation Comprehensive Tests', () {
    test('should handle feature names with numbers', () {
      expect(CLIHelper.isValidFeatureName('feature1'), true);
      expect(CLIHelper.isValidFeatureName('feature123'), true);
      expect(CLIHelper.isValidFeatureName('f1e2a3t4u5r6e'), true);
      expect(CLIHelper.isValidFeatureName('feature_123'), true);
      expect(CLIHelper.isValidFeatureName('feature_123_test'), true);
    });

    test('should handle feature names with underscores', () {
      expect(CLIHelper.isValidFeatureName('my_feature'), true);
      expect(CLIHelper.isValidFeatureName('my_long_feature_name'), true);
      expect(CLIHelper.isValidFeatureName('a_b_c_d_e_f'), true);
      expect(CLIHelper.isValidFeatureName('feature_'), true);
      expect(CLIHelper.isValidFeatureName('feature__test'), true);
    });

    test('should reject names starting with non-letters', () {
      expect(CLIHelper.isValidFeatureName('1feature'), false);
      expect(CLIHelper.isValidFeatureName('_feature'), false);
      expect(CLIHelper.isValidFeatureName('-feature'), false);
      expect(CLIHelper.isValidFeatureName('.feature'), false);
      expect(CLIHelper.isValidFeatureName('#feature'), false);
    });
  });
}
