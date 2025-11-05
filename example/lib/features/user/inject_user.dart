import '../../injection_container.dart';
import 'data/data_sources/remote/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_cases/user_use_case.dart';
import 'presentation/bloc/user_bloc.dart';

//call this function in ServiceLocator.setup() function
injectUser() {
  // bloc
  getIt.registerFactory(() => UserBloc(userUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => UserUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl());
}
      