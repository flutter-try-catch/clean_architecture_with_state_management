abstract class RiverpodNameState {}

class RiverpodNameInitial extends RiverpodNameState {}

class RiverpodNameLoading extends RiverpodNameState {}

class RiverpodNameLoaded extends RiverpodNameState {}

class RiverpodNameError extends RiverpodNameState {
  final Exception exception;
  RiverpodNameError({required this.exception});
}
      