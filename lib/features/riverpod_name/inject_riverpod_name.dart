import '../../injection_container.dart';

import 'data/data_sources/remote/riverpod_name_remote_data_source.dart';
import 'data/repositories/riverpod_name_repository_impl.dart';
import 'domain/repositories/riverpod_name_repository.dart';
import 'domain/use_cases/riverpod_name_use_case.dart';
import 'presentation/provider/riverpod_name_provider.dart';
import 'presentation/provider/riverpod_name_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final riverpodNameProvider =
    StateNotifierProvider<RiverpodNameProvider, RiverpodNameState>((ref) {
  return RiverpodNameProvider(
      riverpodNameUseCase: ref.read(riverpodNameUseCaseProvider));
});
// Repository
final riverpodNameRepositoryProvider = Provider<RiverpodNameRepository>((ref) =>
    RiverpodNameRepositoryImpl(
        remoteDataSource: ref.watch((riverpodNameDataSourceProvider))));

// UseCases
final riverpodNameUseCaseProvider = Provider<RiverpodNameUseCase>(
    (ref) => RiverpodNameUseCase(ref.watch(riverpodNameRepositoryProvider)));

// DataSources
final riverpodNameDataSourceProvider = Provider<RiverpodNameRemoteDataSource>(
    (ref) => RiverpodNameRemoteDataSourceImpl());


