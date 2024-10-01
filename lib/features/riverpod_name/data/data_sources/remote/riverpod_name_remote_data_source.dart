import 'package:dartz/dartz.dart';


abstract class RiverpodNameRemoteDataSource {
  Future<Unit> callApi();
}

class RiverpodNameRemoteDataSourceImpl implements RiverpodNameRemoteDataSource {
  RiverpodNameRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  