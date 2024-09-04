import 'package:dartz/dartz.dart';
import '../repositories/notifications_repository.dart';

class NotificationsUseCase {
  final NotificationsRepository repository;

  NotificationsUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}
