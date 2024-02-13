import 'package:dartz/dartz.dart';
import '../repositories/feat_test_repository.dart';


class FeatTestUseCase {
  final FeatTestRepository repository;

  FeatTestUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

