import 'package:dartz/dartz.dart';


abstract class UserRepository {
  Future<Either<Exception, Unit>> callApi();
}

