import 'package:dartz/dartz.dart';


abstract class NewFeatureLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class NewFeatureLocalDataSourceImpl implements NewFeatureLocalDataSource {
  NewFeatureLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  