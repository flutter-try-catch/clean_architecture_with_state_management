import 'package:dartz/dartz.dart';


abstract class NewFeatBBLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class NewFeatBBLocalDataSourceImpl implements NewFeatBBLocalDataSource {
  NewFeatBBLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  