import 'package:dartz/dartz.dart';


abstract class ProfileLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }

}


  