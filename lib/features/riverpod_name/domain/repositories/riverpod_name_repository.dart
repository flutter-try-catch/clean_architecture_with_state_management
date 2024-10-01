import 'package:dartz/dartz.dart';


abstract class RiverpodNameRepository {
  Future<Either<Exception, Unit>> callApi();
}

