import 'package:dartz/dartz.dart';
import '../repositories/maie_repository.dart';

class MaieUseCase {
  final MaieRepository repository;

  MaieUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}
