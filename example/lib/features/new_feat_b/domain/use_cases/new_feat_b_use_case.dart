import 'package:dartz/dartz.dart';
import '../repositories/new_feat_b_repository.dart';


class NewFeatBUseCase {
  final NewFeatBRepository repository;

  NewFeatBUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

