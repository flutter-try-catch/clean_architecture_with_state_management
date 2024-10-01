import 'package:dartz/dartz.dart';
import '../../domain/repositories/new_feature_repository.dart';
import '../data_sources/remote/new_feature_remote_data_source.dart';


class NewFeatureRepositoryImpl implements NewFeatureRepository {
  final NewFeatureRemoteDataSource remoteDataSource;

  NewFeatureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

