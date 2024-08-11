import '../../injection_container.dart';
import 'data/data_sources/remote/your_feature_name_remote_data_source.dart';
import 'data/repositories/your_feature_name_repository_impl.dart';
import 'domain/repositories/your_feature_name_repository.dart';
import 'domain/use_cases/your_feature_name_use_case.dart';

//call this function in ServiceLocator.setup() function
injectYourFeatureName() {
  // Repository
  getIt.registerLazySingleton<YourFeatureNameRepository>(
      () => YourFeatureNameRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => YourFeatureNameUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<YourFeatureNameRemoteDataSource>(
      () => YourFeatureNameRemoteDataSourceImpl());
}
