import 'package:dartz/dartz.dart';
import '../repositories/feature_name_repository.dart';

class FeatureNameUseCase {
  final FeatureNameRepository repository;

  FeatureNameUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}
