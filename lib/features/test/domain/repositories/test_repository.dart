import 'package:dartz/dartz.dart';


abstract class TestRepository {
  Future<Either<Exception, Unit>> callApi();
}

