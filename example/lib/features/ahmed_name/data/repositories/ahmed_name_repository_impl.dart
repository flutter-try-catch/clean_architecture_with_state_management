import 'package:dartz/dartz.dart';
import '../../domain/repositories/ahmed_name_repository.dart';
import '../data_sources/remote/ahmed_name_remote_data_source.dart';


class AhmedNameRepositoryImpl implements AhmedNameRepository {
  final AhmedNameRemoteDataSource remoteDataSource;

  AhmedNameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

