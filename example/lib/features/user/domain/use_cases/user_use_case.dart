import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';


class UserUseCase {
  final UserRepository repository;

  UserUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

