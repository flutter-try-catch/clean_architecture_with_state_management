import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/remote/feature_name_remote_data_source.dart';
import 'data/repositories/feature_name_repository_impl.dart';
import 'domain/repositories/feature_name_repository.dart';
import 'domain/use_cases/feature_name_use_case.dart';

final featureNameRemoteDataSourceProvider =
    Provider<FeatureNameRemoteDataSource>(
  (ref) => FeatureNameRemoteDataSourceImpl(),
);

final featureNameRepositoryProvider = Provider<FeatureNameRepository>(
  (ref) => FeatureNameRepositoryImpl(
      remoteDataSource: ref.watch(featureNameRemoteDataSourceProvider)),
);

final featureNameUseCaseProvider = Provider<FeatureNameUseCase>(
  (ref) => FeatureNameUseCase(ref.watch(featureNameRepositoryProvider)),
);
