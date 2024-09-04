import '../../injection_container.dart';
import 'data/data_sources/remote/splash_remote_data_source.dart';
import 'data/repositories/splash_repository_impl.dart';
import 'domain/repositories/splash_repository.dart';
import 'domain/use_cases/splash_use_case.dart';
import 'presentation/provider/splash_provider.dart';

//call this function in ServiceLocator.setup() function
injectSplash() {
  // Providers
  getIt.registerFactory(() => SplashProvider(splashUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => SplashUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSourceImpl());
}
