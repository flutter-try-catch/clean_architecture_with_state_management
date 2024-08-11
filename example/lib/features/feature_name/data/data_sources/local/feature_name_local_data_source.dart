import 'package:dartz/dartz.dart';


abstract class FeatureNameLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class FeatureNameLocalDataSourceImpl implements FeatureNameLocalDataSource {
  FeatureNameLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  