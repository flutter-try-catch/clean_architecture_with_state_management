import 'package:dartz/dartz.dart';
import '../../domain/repositories/feat_test_repository.dart';
import '../data_sources/remote/feat_test_remote_data_source.dart';


class FeatTestRepositoryImpl implements FeatTestRepository {
  final FeatTestRemoteDataSource remoteDataSource;

  FeatTestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

