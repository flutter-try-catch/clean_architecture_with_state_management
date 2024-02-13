import '../../injection_container.dart';
import 'data/data_sources/remote/feat_test_remote_data_source.dart';
import 'data/repositories/feat_test_repository_impl.dart';
import 'domain/repositories/feat_test_repository.dart';
import 'domain/use_cases/feat_test_use_case.dart';
import 'presentation/cubit/feat_test_cubit.dart';

//call this function in ServiceLocator.setup() function
injectFeatTest() {
  // cubit
  getIt.registerFactory(() => FeatTestCubit(featTestUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<FeatTestRepository>(
          () => FeatTestRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => FeatTestUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<FeatTestRemoteDataSource>(
          () => FeatTestRemoteDataSourceImpl());
}
      