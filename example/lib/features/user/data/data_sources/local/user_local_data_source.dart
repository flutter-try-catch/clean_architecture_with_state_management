import 'package:dartz/dartz.dart';


abstract class UserLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}
  