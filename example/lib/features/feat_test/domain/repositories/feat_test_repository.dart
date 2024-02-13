import 'package:dartz/dartz.dart';


abstract class FeatTestRepository {
  Future<Either<Exception, Unit>> callApi();
}

