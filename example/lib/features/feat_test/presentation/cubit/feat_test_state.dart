part of 'feat_test_cubit.dart';

abstract class FeatTestState {
  const FeatTestState();
}

class FeatTestInitial extends FeatTestState {
  const FeatTestInitial();
}

class FeatTestLoading extends FeatTestState {
  const FeatTestLoading();
}

class FeatTestLoaded extends FeatTestState {
  const FeatTestLoaded();
}

class FeatTestError extends FeatTestState {
  final Exception exception;
  const FeatTestError(this.exception);
}

