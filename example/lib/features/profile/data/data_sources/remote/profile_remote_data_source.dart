import 'package:dartz/dartz.dart';


abstract class ProfileRemoteDataSource {
  Future<Unit> callApi();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  