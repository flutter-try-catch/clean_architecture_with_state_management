import '../../domain/use_cases/user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;

  UserBloc({required this.userUseCase}) : super(const UserInitial()) {
    on<UserEvent>(_user);
  }

  Future<void> _user(
    UserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await userUseCase.call();
    result.fold(
      (exception) => emit(UserError(exception)),
      (_) => emit(const UserLoaded()),
    );
  }
}

      