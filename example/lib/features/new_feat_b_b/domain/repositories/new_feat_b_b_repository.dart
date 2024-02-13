import 'package:dartz/dartz.dart';


abstract class NewFeatBBRepository {
  Future<Either<Exception, Unit>> callApi();
}

