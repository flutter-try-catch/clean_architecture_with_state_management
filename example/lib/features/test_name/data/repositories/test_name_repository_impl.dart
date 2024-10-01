import 'package:dartz/dartz.dart';
import '../../domain/repositories/test_name_repository.dart';
import '../data_sources/remote/test_name_remote_data_source.dart';


class TestNameRepositoryImpl implements TestNameRepository {
  final TestNameRemoteDataSource remoteDataSource;

  TestNameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

