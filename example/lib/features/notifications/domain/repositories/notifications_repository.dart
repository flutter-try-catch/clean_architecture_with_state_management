import 'package:dartz/dartz.dart';

abstract class NotificationsRepository {
  Future<Either<Exception, Unit>> callApi();
}
