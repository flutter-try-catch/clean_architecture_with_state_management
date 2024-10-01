import 'package:dartz/dartz.dart';


abstract class AhmedNameRemoteDataSource {
  Future<Unit> callApi();
}

class AhmedNameRemoteDataSourceImpl implements AhmedNameRemoteDataSource {
  AhmedNameRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  