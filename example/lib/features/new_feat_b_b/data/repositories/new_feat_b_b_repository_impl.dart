import 'package:dartz/dartz.dart';
import '../../domain/repositories/new_feat_b_b_repository.dart';
import '../data_sources/remote/new_feat_b_b_remote_data_source.dart';


class NewFeatBBRepositoryImpl implements NewFeatBBRepository {
  final NewFeatBBRemoteDataSource remoteDataSource;

  NewFeatBBRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

