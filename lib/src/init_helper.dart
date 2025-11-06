import 'dart:io';

/// Initializes the feature by creating the injection container file if it doesn't exist.
///
/// This function checks if the file 'lib/injection_container.dart' exists. If it doesn't,
/// the function creates the file and writes the necessary import statements and class
/// definition for the injection container.
///
/// Parameters:
/// - `featureName` (String): The name of the feature to be initialized.
///
/// Returns:
/// - `Future<void>`: A future that completes when the initialization is done.
Future<void> init(String featureName) async {
  // Check if the file exists, if not, create it
  final file = File('lib/injection_container.dart');
  if (!file.existsSync()) {
    await file.create(recursive: true);
    await file.writeAsString('''
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

// how to use
/**
 * Future.wait([
    ServiceLocator().setup(),
    ]).then((value) {
    runApp(const MyApp());
    });
 * **/
class ServiceLocator {
  Future<void> setup() async {
    
  }
}
''');
  }
}

