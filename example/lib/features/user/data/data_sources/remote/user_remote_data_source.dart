import 'package:dartz/dartz.dart';


abstract class UserRemoteDataSource {
  Future<Unit> callApi();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  