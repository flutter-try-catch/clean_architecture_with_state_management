import 'package:dartz/dartz.dart';
import '../../domain/repositories/riverpod_name_repository.dart';
import '../data_sources/remote/riverpod_name_remote_data_source.dart';


class RiverpodNameRepositoryImpl implements RiverpodNameRepository {
  final RiverpodNameRemoteDataSource remoteDataSource;

  RiverpodNameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Unit>> callApi() async {
    try {
      return Right(await remoteDataSource.callApi());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }

}

