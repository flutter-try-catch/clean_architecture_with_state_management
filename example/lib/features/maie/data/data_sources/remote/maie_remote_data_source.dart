import 'package:dartz/dartz.dart';

abstract class MaieRemoteDataSource {
  Future<Unit> callApi();
}

class MaieRemoteDataSourceImpl implements MaieRemoteDataSource {
  MaieRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }
}
