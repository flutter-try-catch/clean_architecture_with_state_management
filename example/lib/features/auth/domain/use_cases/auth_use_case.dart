import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';


class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

