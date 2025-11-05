/// Clean Architecture with State Management
///
/// A CLI tool to generate clean architecture boilerplate with various state management solutions.
library clean_architecture_with_state_management;

export 'src/cli_helper.dart';
export 'src/create_clean_architecture.dart' hide createInjectionContainerFile;
export 'src/create_clean_architecture_bloc.dart' hide createInjectionContainerFile;
export 'src/create_clean_architecture_cubit.dart' hide createInjectionContainerFile;
export 'src/create_clean_architecture_provider.dart' hide createInjectionContainerFile, addProviderFiles;
export 'src/create_clean_architecture_riverpod.dart' hide createInjectionContainerFile, addProviderFiles;
export 'src/file_creator.dart';
export 'src/init_helper.dart';
export 'src/string_extensions.dart';

