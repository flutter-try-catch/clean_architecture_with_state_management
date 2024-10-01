abstract class AhmedNameState {}

class AhmedNameInitial extends AhmedNameState {}

class AhmedNameLoading extends AhmedNameState {}

class AhmedNameLoaded extends AhmedNameState {}

class AhmedNameError extends AhmedNameState {
  final Exception exception;
  AhmedNameError({required this.exception});
}
      