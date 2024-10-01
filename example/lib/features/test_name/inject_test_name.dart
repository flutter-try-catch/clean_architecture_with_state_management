import '../../injection_container.dart';

import 'data/data_sources/remote/test_name_remote_data_source.dart';
import 'data/repositories/test_name_repository_impl.dart';
import 'domain/repositories/test_name_repository.dart';
import 'domain/use_cases/test_name_use_case.dart';
import 'presentation/provider/test_name_provider.dart';
import 'presentation/provider/test_name_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final testNameProvider =
    StateNotifierProvider<TestNameProvider, TestNameState>((ref) {
  return TestNameProvider(
      testNameUseCase: ref.read(testNameUseCaseProvider));
});
// Repository
final testNameRepositoryProvider = Provider<TestNameRepository>((ref) =>
    TestNameRepositoryImpl(
        remoteDataSource: ref.watch((testNameDataSourceProvider))));

// UseCases
final testNameUseCaseProvider = Provider<TestNameUseCase>(
    (ref) => TestNameUseCase(ref.watch(testNameRepositoryProvider)));

// DataSources
final testNameDataSourceProvider = Provider<TestNameRemoteDataSource>(
    (ref) => TestNameRemoteDataSourceImpl());


