import 'package:dartz/dartz.dart';

abstract class SplashRemoteDataSource {
  Future<Unit> callApi();
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  SplashRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }
}
