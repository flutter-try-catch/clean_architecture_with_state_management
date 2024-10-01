import 'package:dartz/dartz.dart';
import '../repositories/riverpod_name_repository.dart';


class RiverpodNameUseCase {
  final RiverpodNameRepository repository;

  RiverpodNameUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

