import 'package:dartz/dartz.dart';


abstract class TestProviderRemoteDataSource {
  Future<Unit> callApi();
}

class TestProviderRemoteDataSourceImpl implements TestProviderRemoteDataSource {
  TestProviderRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  