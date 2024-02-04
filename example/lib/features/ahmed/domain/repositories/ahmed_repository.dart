import 'package:dartz/dartz.dart';


abstract class AhmedRepository {
  Future<Either<Exception, Unit>> callApi();
}

