import 'package:dartz/dartz.dart';


abstract class TestProviderRepository {
  Future<Either<Exception, Unit>> callApi();
}

