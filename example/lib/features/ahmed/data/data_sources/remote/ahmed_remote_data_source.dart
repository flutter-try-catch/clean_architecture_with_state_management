import 'package:dartz/dartz.dart';


abstract class AhmedRemoteDataSource {
  Future<Unit> callApi();
}

class AhmedRemoteDataSourceImpl implements AhmedRemoteDataSource {
  AhmedRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  