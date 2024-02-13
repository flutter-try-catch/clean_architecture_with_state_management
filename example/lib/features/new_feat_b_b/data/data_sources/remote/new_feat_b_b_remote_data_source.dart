import 'package:dartz/dartz.dart';


abstract class NewFeatBBRemoteDataSource {
  Future<Unit> callApi();
}

class NewFeatBBRemoteDataSourceImpl implements NewFeatBBRemoteDataSource {
  NewFeatBBRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  