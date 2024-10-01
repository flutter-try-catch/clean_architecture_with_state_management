import 'package:dartz/dartz.dart';
import '../repositories/ahmed_name_repository.dart';


class AhmedNameUseCase {
  final AhmedNameRepository repository;

  AhmedNameUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

