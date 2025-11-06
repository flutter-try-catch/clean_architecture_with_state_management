part of 'user_bloc.dart';
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}
class UserLoading extends UserState {
  const UserLoading();
}
class UserLoaded extends UserState {
  const UserLoaded();
}
class UserError extends UserState {
  final Exception exception;
  const UserError(this.exception);
}

