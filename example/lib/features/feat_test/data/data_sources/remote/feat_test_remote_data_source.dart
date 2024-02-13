import 'package:dartz/dartz.dart';


abstract class FeatTestRemoteDataSource {
  Future<Unit> callApi();
}

class FeatTestRemoteDataSourceImpl implements FeatTestRemoteDataSource {
  FeatTestRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  