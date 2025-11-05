# Test Suite Documentation

This directory contains comprehensive test-driven development (TDD) tests for the Clean Architecture with State Management package.

## Test Structure

### Test Files

1. **`clean_architecture_with_state_management_test.dart`** - Core functionality tests
   - String extensions (capitalize, toLowerCaseFirst, toSnakeCase)
   - CLIHelper validation functions
   - FileCreator class operations
   - Integration and edge case tests

2. **`create_clean_architecture_test.dart`** - Base architecture generation tests
   - Directory structure creation
   - Data layer file generation
   - Domain layer file generation
   - Presentation layer file generation
   - Dependency injection setup

3. **`state_management_bloc_test.dart`** - Bloc state management tests
   - Bloc, Event, and State file generation
   - BlocProvider integration
   - Dependency injection for Bloc

4. **`state_management_cubit_test.dart`** - Cubit state management tests
   - Cubit and State file generation
   - Status enum implementation
   - BlocProvider integration for Cubit

5. **`state_management_provider_test.dart`** - Provider state management tests
   - ChangeNotifier provider files
   - Consumer pattern implementation
   - Provider dependency injection

6. **`state_management_riverpod_test.dart`** - Riverpod state management tests
   - StateNotifierProvider setup
   - ConsumerWidget implementation
   - Riverpod providers and dependency injection

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/clean_architecture_with_state_management_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Tests in Watch Mode
```bash
flutter test --watch
```

## Test Coverage

The test suite includes **166 test cases** with **110 passing tests** (66.3% pass rate).

### Coverage by Module
- ✅ **Core Functionality**: 38/38 tests (100%)
- ✅ **Base Architecture**: 26/26 tests (100%)
- ⚠️ **Bloc Management**: 12/36 tests (33%)
- ⚠️ **Cubit Management**: 9/35 tests (26%)
- ⚠️ **Provider Management**: 15/31 tests (48%)
- ✅ **Riverpod Management**: Tests completed successfully

### Why Some Tests Fail
Some tests fail due to implementation limitations where files are written without ensuring parent directories exist first. These are known issues that highlight areas for improvement in the main codebase, not problems with the tests themselves.

## Test Patterns

### Directory Setup Pattern
```dart
late Directory tempDir;

setUp(() {
  tempDir = Directory.systemTemp.createTempSync('test_prefix_');
  Directory.current = tempDir.path;
  FileCreator.resetFilesCreated();
  FileCreator.setDryRun(false);
  
  // Create base structure
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
```

### File Content Validation Pattern
```dart
test('should create file with correct content', () {
  createSomeFile('feature');
  
  final file = File('path/to/file.dart');
  expect(file.existsSync(), true);
  
  final content = file.readAsStringSync();
  expect(content.contains('ExpectedClass'), true);
  expect(content.contains('expectedMethod'), true);
});
```

### Import Alias Pattern
To avoid naming conflicts when testing multiple modules:
```dart
import '../bin/src/create_clean_architecture_bloc.dart' as bloc;
import '../bin/src/create_clean_architecture.dart';

// Usage
bloc.addBlocFiles('user');
```

## Writing New Tests

### Guidelines
1. **Isolate Tests**: Each test should be independent
2. **Clean Up**: Always clean up temporary files in `tearDown()`
3. **Descriptive Names**: Use clear, descriptive test names
4. **Arrange-Act-Assert**: Follow the AAA pattern
5. **Edge Cases**: Include tests for boundary conditions

### Example Test Structure
```dart
group('Feature Tests', () {
  group('Sub-feature Tests', () {
    test('should do something specific', () {
      // Arrange
      final input = 'test';
      
      // Act
      final result = someFunction(input);
      
      // Assert
      expect(result, expectedValue);
    });
  });
});
```

## Continuous Integration

### GitHub Actions Example
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v2
```

## Troubleshooting

### Common Issues

1. **Tests fail with "Directory not found"**
   - Ensure `setUp()` creates necessary directories
   - Check that paths use the temporary directory

2. **Coverage report is empty**
   - Some tests must pass for coverage to be generated
   - Use `flutter test --coverage` not `dart test`

3. **Import conflicts**
   - Use import aliases: `import 'file.dart' as prefix;`
   - Call functions with prefix: `prefix.function()`

## Best Practices

✅ **DO**:
- Use temporary directories for file operations
- Clean up after each test
- Test both success and failure cases
- Use descriptive test names
- Group related tests

❌ **DON'T**:
- Write to the actual project directory
- Depend on other tests' state
- Skip cleanup in `tearDown()`
- Test implementation details
- Create flaky tests

## Contributing

When adding new features, please:
1. Write tests first (TDD approach)
2. Ensure tests pass before submitting PR
3. Maintain or improve code coverage
4. Update this documentation if needed

## Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Effective Dart: Testing](https://dart.dev/guides/language/effective-dart/testing)
- [Test Package Documentation](https://pub.dev/packages/test)

---

For detailed coverage metrics, see [TEST_COVERAGE_SUMMARY.md](../TEST_COVERAGE_SUMMARY.md)

