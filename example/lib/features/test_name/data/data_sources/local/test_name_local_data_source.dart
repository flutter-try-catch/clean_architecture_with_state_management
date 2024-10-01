import 'package:dartz/dartz.dart';


abstract class TestNameLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class TestNameLocalDataSourceImpl implements TestNameLocalDataSource {
  TestNameLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  