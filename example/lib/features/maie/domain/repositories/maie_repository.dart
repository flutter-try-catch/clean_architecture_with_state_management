import 'package:dartz/dartz.dart';

abstract class MaieRepository {
  Future<Either<Exception, Unit>> callApi();
}
