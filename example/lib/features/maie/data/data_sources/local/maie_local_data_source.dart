import 'package:dartz/dartz.dart';

abstract class MaieLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class MaieLocalDataSourceImpl implements MaieLocalDataSource {
  MaieLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }
}
