abstract class AhmedNameState {}

class AhmedNameInitial extends AhmedNameState {}

class AhmedNameLoading extends AhmedNameState {}

class AhmedNameLoaded extends AhmedNameState {
  final String data;
  AhmedNameLoaded({required this.data});
}

class AhmedNameError extends AhmedNameState {
  final Exception exception;
  AhmedNameError({required this.exception});
}
      