abstract class TestNameState {}

class TestNameInitial extends TestNameState {}

class TestNameLoading extends TestNameState {}

class TestNameLoaded extends TestNameState {}

class TestNameError extends TestNameState {
  final Exception exception;
  TestNameError({required this.exception});
}
      