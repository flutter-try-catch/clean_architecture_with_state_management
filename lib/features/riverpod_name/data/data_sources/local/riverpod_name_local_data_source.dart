import 'package:dartz/dartz.dart';


abstract class RiverpodNameLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class RiverpodNameLocalDataSourceImpl implements RiverpodNameLocalDataSource {
  RiverpodNameLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  