import 'package:dartz/dartz.dart';


abstract class TestProviderLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class TestProviderLocalDataSourceImpl implements TestProviderLocalDataSource {
  TestProviderLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  