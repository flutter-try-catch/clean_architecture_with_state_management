import 'package:dartz/dartz.dart';
import '../../domain/repositories/test_provider_repository.dart';
import '../data_sources/remote/test_provider_remote_data_source.dart';


class TestProviderRepositoryImpl implements TestProviderRepository {
  final TestProviderRemoteDataSource remoteDataSource;

  TestProviderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

