import 'package:dartz/dartz.dart';


abstract class NewFeatureRepository {
  Future<Either<Exception, Unit>> callApi();
}

