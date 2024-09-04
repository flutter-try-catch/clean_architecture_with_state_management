import 'package:dartz/dartz.dart';

abstract class NotificationsLocalDataSource {
  Future<Unit> getFromLocalDataBase();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  NotificationsLocalDataSourceImpl();

  @override
  Future<Unit> getFromLocalDataBase() async {
    // send api request here
    return Future.value(unit);
  }
}
