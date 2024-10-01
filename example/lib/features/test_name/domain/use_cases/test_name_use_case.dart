import 'package:dartz/dartz.dart';
import '../repositories/test_name_repository.dart';


class TestNameUseCase {
  final TestNameRepository repository;

  TestNameUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

