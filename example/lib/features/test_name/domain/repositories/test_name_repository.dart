import 'package:dartz/dartz.dart';


abstract class TestNameRepository {
  Future<Either<Exception, Unit>> callApi();
}

