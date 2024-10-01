import 'package:dartz/dartz.dart';
import '../repositories/new_feature_repository.dart';


class NewFeatureUseCase {
  final NewFeatureRepository repository;

  NewFeatureUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

