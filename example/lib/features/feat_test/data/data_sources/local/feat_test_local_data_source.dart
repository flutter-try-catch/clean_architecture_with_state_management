import 'package:dartz/dartz.dart';


abstract class FeatTestLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class FeatTestLocalDataSourceImpl implements FeatTestLocalDataSource {
  FeatTestLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  