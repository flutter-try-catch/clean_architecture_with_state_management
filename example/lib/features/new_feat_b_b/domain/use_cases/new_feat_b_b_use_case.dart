import 'package:dartz/dartz.dart';
import '../repositories/new_feat_b_b_repository.dart';


class NewFeatBBUseCase {
  final NewFeatBBRepository repository;

  NewFeatBBUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

