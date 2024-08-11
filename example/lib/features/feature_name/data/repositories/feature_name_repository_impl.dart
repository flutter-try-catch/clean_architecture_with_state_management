import 'package:dartz/dartz.dart';
import '../../domain/repositories/feature_name_repository.dart';
import '../data_sources/remote/feature_name_remote_data_source.dart';

class FeatureNameRepositoryImpl implements FeatureNameRepository {
  final FeatureNameRemoteDataSource remoteDataSource;

  FeatureNameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }
}
