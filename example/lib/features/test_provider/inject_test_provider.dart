import '../../injection_container.dart';
import 'data/data_sources/remote/test_provider_remote_data_source.dart';
import 'data/repositories/test_provider_repository_impl.dart';
import 'domain/repositories/test_provider_repository.dart';
import 'domain/use_cases/test_provider_use_case.dart';
import 'presentation/provider/test_provider_provider.dart';

//call this function in ServiceLocator.setup() function
injectTestProvider() {
  // Providers
  getIt.registerFactory(() => TestProviderProvider(testProviderUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<TestProviderRepository>(
          () => TestProviderRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => TestProviderUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<TestProviderRemoteDataSource>(
          () => TestProviderRemoteDataSourceImpl());
}
      