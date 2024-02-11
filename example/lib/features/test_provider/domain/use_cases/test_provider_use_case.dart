import 'package:dartz/dartz.dart';
import '../repositories/test_provider_repository.dart';


class TestProviderUseCase {
  final TestProviderRepository repository;

  TestProviderUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

