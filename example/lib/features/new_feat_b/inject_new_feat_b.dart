import '../../injection_container.dart';
import 'data/data_sources/remote/new_feat_b_remote_data_source.dart';
import 'data/repositories/new_feat_b_repository_impl.dart';
import 'domain/repositories/new_feat_b_repository.dart';
import 'domain/use_cases/new_feat_b_use_case.dart';
import 'presentation/bloc/new_feat_b_bloc.dart';

//call this function in ServiceLocator.setup() function
injectNewFeatB() {
  // bloc
  getIt.registerFactory(() => NewFeatBBloc(newFeatBUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<NewFeatBRepository>(
          () => NewFeatBRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => NewFeatBUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<NewFeatBRemoteDataSource>(
          () => NewFeatBRemoteDataSourceImpl());
}
      