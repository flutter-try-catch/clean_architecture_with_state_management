import 'package:dartz/dartz.dart';


abstract class AuthRemoteDataSource {
  Future<Unit> callApi();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  