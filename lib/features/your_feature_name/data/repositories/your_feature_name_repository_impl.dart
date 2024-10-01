import 'package:dartz/dartz.dart';
import '../../domain/repositories/your_feature_name_repository.dart';
import '../data_sources/remote/your_feature_name_remote_data_source.dart';


class YourFeatureNameRepositoryImpl implements YourFeatureNameRepository {
  final YourFeatureNameRemoteDataSource remoteDataSource;

  YourFeatureNameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

