import 'package:dartz/dartz.dart';


abstract class AuthLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}
  