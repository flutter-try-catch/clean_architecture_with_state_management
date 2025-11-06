import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/remote/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/auth_use_case.dart';
import 'presentation/provider/auth_provider.dart';
import 'presentation/provider/auth_state.dart';


// Providers
final authProvider =
    StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(
      authUseCase: ref.read(authUseCaseProvider));
});
// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepositoryImpl(
        remoteDataSource: ref.watch((authDataSourceProvider))));

// UseCases
final authUseCaseProvider = Provider<AuthUseCase>(
    (ref) => AuthUseCase(ref.watch(authRepositoryProvider)));

// DataSources
final authDataSourceProvider = Provider<AuthRemoteDataSource>(
    (ref) => AuthRemoteDataSourceImpl());


