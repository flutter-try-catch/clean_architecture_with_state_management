import 'package:dartz/dartz.dart';


abstract class YourFeatureNameRepository {
  Future<Either<Exception, Unit>> callApi();
}

