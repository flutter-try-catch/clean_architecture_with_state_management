import 'package:dartz/dartz.dart';


abstract class ProfileRepository {
  Future<Either<Exception, Unit>> callApi();
}

