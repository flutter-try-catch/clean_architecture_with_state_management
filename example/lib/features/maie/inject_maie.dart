import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection_container.dart';
import 'data/data_sources/remote/maie_remote_data_source.dart';
import 'data/repositories/maie_repository_impl.dart';
import 'domain/repositories/maie_repository.dart';
import 'domain/use_cases/maie_use_case.dart';
import 'presentation/provider/maie_provider.dart';
import 'presentation/provider/maie_state.dart';

//call this function in ServiceLocator.setup() function
injectMaie() {
  // Repository
  getIt.registerLazySingleton<MaieRepository>(
      () => MaieRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => MaieUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<MaieRemoteDataSource>(
      () => MaieRemoteDataSourceImpl());

  // Providers
  // getIt.registerFactory(() => StateNotifierProvider<MaieProvider, MaieState>(
  //       (ref) {
  //         return MaieProvider(
  //           maieUseCase: getIt(),
  //         );
  //       },
  //     ));
}
