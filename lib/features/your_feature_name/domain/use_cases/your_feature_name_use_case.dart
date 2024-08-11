import 'package:dartz/dartz.dart';
import '../repositories/your_feature_name_repository.dart';

class YourFeatureNameUseCase {
  final YourFeatureNameRepository repository;

  YourFeatureNameUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}
