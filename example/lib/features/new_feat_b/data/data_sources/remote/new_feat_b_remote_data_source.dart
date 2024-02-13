import 'package:dartz/dartz.dart';


abstract class NewFeatBRemoteDataSource {
  Future<Unit> callApi();
}

class NewFeatBRemoteDataSourceImpl implements NewFeatBRemoteDataSource {
  NewFeatBRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  