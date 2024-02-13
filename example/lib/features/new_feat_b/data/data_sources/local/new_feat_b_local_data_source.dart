import 'package:dartz/dartz.dart';


abstract class NewFeatBLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class NewFeatBLocalDataSourceImpl implements NewFeatBLocalDataSource {
  NewFeatBLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  