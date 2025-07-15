import 'package:dartz/dartz.dart';


abstract class TestLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class TestLocalDataSourceImpl implements TestLocalDataSource {
  TestLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  