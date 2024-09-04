import 'package:dartz/dartz.dart';
import '../../domain/repositories/maie_repository.dart';
import '../data_sources/remote/maie_remote_data_source.dart';

class MaieRepositoryImpl implements MaieRepository {
  final MaieRemoteDataSource remoteDataSource;

  MaieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }
}
