import 'package:dartz/dartz.dart';


abstract class AhmedNameLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class AhmedNameLocalDataSourceImpl implements AhmedNameLocalDataSource {
  AhmedNameLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  