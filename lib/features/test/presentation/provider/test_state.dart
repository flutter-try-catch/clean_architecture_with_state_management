abstract class TestState {}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestLoaded extends TestState {}

class TestError extends TestState {
  final Exception exception;
  TestError({required this.exception});
}
      