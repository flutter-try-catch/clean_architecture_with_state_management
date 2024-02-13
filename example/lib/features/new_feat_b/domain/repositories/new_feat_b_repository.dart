import 'package:dartz/dartz.dart';


abstract class NewFeatBRepository {
  Future<Either<Exception, Unit>> callApi();
}

