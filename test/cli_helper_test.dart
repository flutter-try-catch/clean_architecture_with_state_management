import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_state_management/src/cli_helper.dart';

void main() {
  group('CLIHelper Tests', () {
    group('isValidFeatureName()', () {
      test('should return true for valid feature names', () {
        expect(CLIHelper.isValidFeatureName('user'), true);
        expect(CLIHelper.isValidFeatureName('userProfile'), true);
        expect(CLIHelper.isValidFeatureName('user_profile'), true);
        expect(CLIHelper.isValidFeatureName('myFeature123'), true);
        expect(CLIHelper.isValidFeatureName('a'), true);
      });

      test('should return false for invalid feature names', () {
        expect(CLIHelper.isValidFeatureName('123user'), false);
        expect(CLIHelper.isValidFeatureName('_user'), false);
        expect(CLIHelper.isValidFeatureName('user-profile'), false);
        expect(CLIHelper.isValidFeatureName('user profile'), false);
        expect(CLIHelper.isValidFeatureName(''), false);
        expect(CLIHelper.isValidFeatureName('user!'), false);
      });
    });

    group('Output Methods - Basic Smoke Tests', () {
      // These tests verify the methods can be called without throwing
      // Actual output testing would require stdout mocking which is complex
      
      test('info() should not throw', () {
        expect(() => CLIHelper.info('test message'), returnsNormally);
      });

      test('success() should not throw', () {
        expect(() => CLIHelper.success('operation completed'), returnsNormally);
      });

      test('warning() should not throw', () {
        expect(() => CLIHelper.warning('be careful'), returnsNormally);
      });

      test('error() should not throw', () {
        expect(() => CLIHelper.error('something went wrong'), returnsNormally);
      });

      test('step() should not throw', () {
        expect(() => CLIHelper.step('doing something'), returnsNormally);
      });

      test('fileCreated() should not throw', () {
        expect(() => CLIHelper.fileCreated('lib/test.dart'), returnsNormally);
      });

      test('fileSkipped() should not throw', () {
        expect(() => CLIHelper.fileSkipped('lib/exists.dart'), returnsNormally);
      });
    });

    group('Header and Section Methods', () {
      test('header() should not throw', () {
        expect(() => CLIHelper.header('Test Header'), returnsNormally);
      });

      test('section() should not throw', () {
        expect(() => CLIHelper.section('Test Section'), returnsNormally);
      });

      test('complete() should not throw without filesCreated', () {
        expect(() => CLIHelper.complete('Task done'), returnsNormally);
      });

      test('complete() should not throw with filesCreated', () {
        expect(() => CLIHelper.complete('Task done', filesCreated: 5), returnsNormally);
      });
    });

    group('Summary Functions', () {
      test('printSummary() should not throw with state management', () {
        expect(() => CLIHelper.printSummary(
          featureName: 'user',
          stateManagement: 'bloc',
          dryRun: false,
        ), returnsNormally);
      });

      test('printSummary() should not throw without state management', () {
        expect(() => CLIHelper.printSummary(
          featureName: 'product',
          stateManagement: null,
          dryRun: true,
        ), returnsNormally);
      });

      test('printSummary() with different state management options', () {
        expect(() => CLIHelper.printSummary(
          featureName: 'auth',
          stateManagement: 'cubit',
          dryRun: false,
        ), returnsNormally);

        expect(() => CLIHelper.printSummary(
          featureName: 'profile',
          stateManagement: 'provider',
          dryRun: false,
        ), returnsNormally);

        expect(() => CLIHelper.printSummary(
          featureName: 'settings',
          stateManagement: 'riverpod',
          dryRun: true,
        ), returnsNormally);
      });
    });

    group('Welcome and Help Functions', () {
      test('printWelcome() should not throw', () {
        expect(() => CLIHelper.printWelcome(), returnsNormally);
      });

      test('printTips() should not throw', () {
        expect(() => CLIHelper.printTips(), returnsNormally);
      });

      test('printHelp() should not throw', () {
        expect(() => CLIHelper.printHelp(), returnsNormally);
      });
    });

    group('Spinner Function', () {
      test('spinner() should execute async task successfully', () async {
        var taskExecuted = false;
        
        await CLIHelper.spinner('Testing', () async {
          taskExecuted = true;
          await Future.delayed(Duration(milliseconds: 10));
        });
        
        expect(taskExecuted, true);
      });

      test('spinner() should execute task and return', () async {
        final result = await CLIHelper.spinner('Loading', () async {
          await Future.delayed(Duration(milliseconds: 5));
          return 'success';
        });
        
        expect(result, 'success');
      });

      test('spinner() should handle errors and propagate them', () async {
        expect(
          () => CLIHelper.spinner('Failing task', () async {
            throw Exception('Test error');
          }),
          throwsException,
        );
      });

      test('spinner() with different message', () async {
        var executed = false;
        await CLIHelper.spinner('Processing data', () async {
          executed = true;
        });
        expect(executed, true);
      });
    });

    group('Function Existence Tests', () {
      // These verify the functions exist (can't easily test interactive input/output)
      
      test('input() function should be callable', () {
        expect(CLIHelper.input, isNotNull);
        expect(CLIHelper.input is Function, true);
      });

      test('confirm() function should be callable', () {
        expect(CLIHelper.confirm, isNotNull);
        expect(CLIHelper.confirm is Function, true);
      });

      test('select() function should be callable', () {
        expect(CLIHelper.select, isNotNull);
        expect(CLIHelper.select is Function, true);
      });
    });
  });
}

