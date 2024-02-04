import 'package:dartz/dartz.dart';
import '../repositories/ahmed_repository.dart';


class AhmedUseCase {
  final AhmedRepository repository;

  AhmedUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

