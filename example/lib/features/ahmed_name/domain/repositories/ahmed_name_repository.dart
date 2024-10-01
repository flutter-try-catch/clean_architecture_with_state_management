import 'package:dartz/dartz.dart';


abstract class AhmedNameRepository {
  Future<Either<Exception, Unit>> callApi();
}

