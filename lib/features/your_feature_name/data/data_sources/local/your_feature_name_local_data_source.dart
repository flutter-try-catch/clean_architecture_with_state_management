import 'package:dartz/dartz.dart';

abstract class YourFeatureNameLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class YourFeatureNameLocalDataSourceImpl
    implements YourFeatureNameLocalDataSource {
  YourFeatureNameLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }
}
