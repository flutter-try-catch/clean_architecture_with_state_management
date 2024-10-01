import '../../injection_container.dart';

import 'data/data_sources/remote/new_feature_remote_data_source.dart';
import 'data/repositories/new_feature_repository_impl.dart';
import 'domain/repositories/new_feature_repository.dart';
import 'domain/use_cases/new_feature_use_case.dart';
import 'presentation/provider/new_feature_provider.dart';
import 'presentation/provider/new_feature_state.dart';
import 'package:riverpod/riverpod.dart';


// Providers
final newFeatureProvider =
    StateNotifierProvider<NewFeatureProvider, NewFeatureState>((ref) {
  return NewFeatureProvider(
      newFeatureUseCase: ref.read(newFeatureUseCaseProvider));
});
// Repository
final newFeatureRepositoryProvider = Provider<NewFeatureRepository>((ref) =>
    NewFeatureRepositoryImpl(
        remoteDataSource: ref.watch((newFeatureDataSourceProvider))));

// UseCases
final newFeatureUseCaseProvider = Provider<NewFeatureUseCase>(
    (ref) => NewFeatureUseCase(ref.watch(newFeatureRepositoryProvider)));

// DataSources
final newFeatureDataSourceProvider = Provider<NewFeatureRemoteDataSource>(
    (ref) => NewFeatureRemoteDataSourceImpl());


