import 'package:get_it/get_it.dart';

import 'features/maie/inject_maie.dart';

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
    // injectMaie();
  }
}
