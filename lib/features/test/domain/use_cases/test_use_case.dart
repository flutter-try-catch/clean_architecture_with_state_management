import 'package:dartz/dartz.dart';
import '../repositories/test_repository.dart';


class TestUseCase {
  final TestRepository repository;

  TestUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

