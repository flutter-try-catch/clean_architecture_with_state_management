import '../../injection_container.dart';
import 'data/data_sources/remote/test_remote_data_source.dart';
import 'data/repositories/test_repository_impl.dart';
import 'domain/repositories/test_repository.dart';
import 'domain/use_cases/test_use_case.dart';

//call this function in ServiceLocator.setup() function
injectTest() {

  // Repository
  getIt.registerLazySingleton<TestRepository>(
          () => TestRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => TestUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<TestRemoteDataSource>(
          () => TestRemoteDataSourceImpl());
}
      