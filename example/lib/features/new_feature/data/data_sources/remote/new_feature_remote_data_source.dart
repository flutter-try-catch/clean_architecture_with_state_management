import 'package:dartz/dartz.dart';


abstract class NewFeatureRemoteDataSource {
  Future<Unit> callApi();
}

class NewFeatureRemoteDataSourceImpl implements NewFeatureRemoteDataSource {
  NewFeatureRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  