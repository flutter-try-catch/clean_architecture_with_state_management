import 'package:dartz/dartz.dart';
import '../../domain/repositories/ahmed_repository.dart';
import '../data_sources/remote/ahmed_remote_data_source.dart';


class AhmedRepositoryImpl implements AhmedRepository {
  final AhmedRemoteDataSource remoteDataSource;

  AhmedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

