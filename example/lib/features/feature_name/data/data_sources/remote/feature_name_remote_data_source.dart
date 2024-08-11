import 'package:dartz/dartz.dart';


abstract class FeatureNameRemoteDataSource {
  Future<Unit> callApi();
}

class FeatureNameRemoteDataSourceImpl implements FeatureNameRemoteDataSource {
  FeatureNameRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  