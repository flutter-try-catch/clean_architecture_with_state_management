import 'package:dartz/dartz.dart';


abstract class YourFeatureNameRemoteDataSource {
  Future<Unit> callApi();
}

class YourFeatureNameRemoteDataSourceImpl implements YourFeatureNameRemoteDataSource {
  YourFeatureNameRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  