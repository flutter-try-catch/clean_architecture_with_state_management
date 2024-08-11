import 'package:dartz/dartz.dart';

abstract class FeatureNameRepository {
  Future<Either<Exception, Unit>> callApi();
}
