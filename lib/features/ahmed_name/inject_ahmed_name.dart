import '../../injection_container.dart';

import 'data/data_sources/remote/ahmed_name_remote_data_source.dart';
import 'data/repositories/ahmed_name_repository_impl.dart';
import 'domain/repositories/ahmed_name_repository.dart';
import 'domain/use_cases/ahmed_name_use_case.dart';
import 'presentation/provider/ahmed_name_provider.dart';
import 'presentation/provider/ahmed_name_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final ahmedNameProvider =
    StateNotifierProvider<AhmedNameProvider, AhmedNameState>((ref) {
  return AhmedNameProvider(
      ahmedNameUseCase: ref.read(ahmedNameUseCaseProvider));
});
// Repository
final ahmedNameRepositoryProvider = Provider<AhmedNameRepository>((ref) =>
    AhmedNameRepositoryImpl(
        remoteDataSource: ref.watch((ahmedNameDataSourceProvider))));

// UseCases
final ahmedNameUseCaseProvider = Provider<AhmedNameUseCase>(
    (ref) => AhmedNameUseCase(ref.watch(ahmedNameRepositoryProvider)));

// DataSources
final ahmedNameDataSourceProvider = Provider<AhmedNameRemoteDataSource>(
    (ref) => AhmedNameRemoteDataSourceImpl());


