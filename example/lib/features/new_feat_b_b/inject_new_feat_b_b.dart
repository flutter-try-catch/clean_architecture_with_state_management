import '../../injection_container.dart';
import 'data/data_sources/remote/new_feat_b_b_remote_data_source.dart';
import 'data/repositories/new_feat_b_b_repository_impl.dart';
import 'domain/repositories/new_feat_b_b_repository.dart';
import 'domain/use_cases/new_feat_b_b_use_case.dart';
import 'presentation/bloc/new_feat_b_b_bloc.dart';

//call this function in ServiceLocator.setup() function
injectNewFeatBB() {
  // bloc
  getIt.registerFactory(() => NewFeatBBBloc(newFeatBBUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<NewFeatBBRepository>(
          () => NewFeatBBRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => NewFeatBBUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<NewFeatBBRemoteDataSource>(
          () => NewFeatBBRemoteDataSourceImpl());
}
      