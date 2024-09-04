import 'package:dartz/dartz.dart';
import '../repositories/splash_repository.dart';

class SplashUseCase {
  final SplashRepository repository;

  SplashUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}
