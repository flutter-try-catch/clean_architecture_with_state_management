import '../../injection_container.dart';
import 'data/data_sources/remote/notifications_remote_data_source.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'domain/repositories/notifications_repository.dart';
import 'domain/use_cases/notifications_use_case.dart';
import 'presentation/provider/notifications_provider.dart';

//call this function in ServiceLocator.setup() function
injectNotifications() {
  // Providers
  getIt.registerFactory(
      () => NotificationsProvider(notificationsUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => NotificationsUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl());
}
