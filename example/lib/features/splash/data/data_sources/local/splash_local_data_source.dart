import 'package:dartz/dartz.dart';

abstract class SplashLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  SplashLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }
}
