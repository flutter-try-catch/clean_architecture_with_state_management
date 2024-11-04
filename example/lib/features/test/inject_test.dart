import '../../injection_container.dart';

import 'data/data_sources/remote/test_remote_data_source.dart';
import 'data/repositories/test_repository_impl.dart';
import 'domain/repositories/test_repository.dart';
import 'domain/use_cases/test_use_case.dart';
import 'presentation/provider/test_provider.dart';
import 'presentation/provider/test_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final testProvider =
    StateNotifierProvider<TestProvider, TestState>((ref) {
  return TestProvider(
      testUseCase: ref.read(testUseCaseProvider));
});
// Repository
final testRepositoryProvider = Provider<TestRepository>((ref) =>
    TestRepositoryImpl(
        remoteDataSource: ref.watch((testDataSourceProvider))));

// UseCases
final testUseCaseProvider = Provider<TestUseCase>(
    (ref) => TestUseCase(ref.watch(testRepositoryProvider)));

// DataSources
final testDataSourceProvider = Provider<TestRemoteDataSource>(
    (ref) => TestRemoteDataSourceImpl());


