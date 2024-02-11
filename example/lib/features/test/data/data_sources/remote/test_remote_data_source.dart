import 'package:dartz/dartz.dart';


abstract class TestRemoteDataSource {
  Future<Unit> callApi();
}

class TestRemoteDataSourceImpl implements TestRemoteDataSource {
  TestRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  