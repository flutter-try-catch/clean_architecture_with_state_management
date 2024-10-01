import 'package:dartz/dartz.dart';


abstract class TestNameRemoteDataSource {
  Future<Unit> callApi();
}

class TestNameRemoteDataSourceImpl implements TestNameRemoteDataSource {
  TestNameRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  