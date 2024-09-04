import 'package:dartz/dartz.dart';

abstract class NotificationsRemoteDataSource {
  Future<Unit> callApi();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }
}
