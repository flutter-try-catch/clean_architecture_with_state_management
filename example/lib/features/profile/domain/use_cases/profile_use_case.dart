import 'package:dartz/dartz.dart';
import '../repositories/profile_repository.dart';


class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<Either<Exception, Unit>> call() async {
    return await repository.callApi();
  }
}

