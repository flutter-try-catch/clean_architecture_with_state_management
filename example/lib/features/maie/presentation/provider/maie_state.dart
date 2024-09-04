abstract class MaieState {}

class MaieInitial extends MaieState {}

class MaieLoading extends MaieState {}

class MaieLoaded extends MaieState {}

class MaieError extends MaieState {
  final Exception exception;
  MaieError({required this.exception});
}
