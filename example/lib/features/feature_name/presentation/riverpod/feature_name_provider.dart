import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/feature_name_use_case.dart';
import '../../inject_feature_name.dart';

final featureNameProvider =
    StateNotifierProvider<FeatureNameNotifier, FeatureNameState>((ref) {
  return FeatureNameNotifier(
      featureNameUseCase: ref.watch(featureNameUseCaseProvider));
});

class FeatureNameNotifier extends StateNotifier<FeatureNameState> {
  final FeatureNameUseCase featureNameUseCase;

  FeatureNameNotifier({required this.featureNameUseCase})
      : super(FeatureNameInitial());

  int count = 0;
  Future<void> fetchData() async {
    state = FeatureNameLoading();
    final result = await featureNameUseCase.call();
    result.fold(
      (exception) => state = FeatureNameError(exception),
      (_) => state = FeatureNameLoaded(count: count++),
    );
  }
}

abstract class FeatureNameState {}

class FeatureNameInitial extends FeatureNameState {}

class FeatureNameLoading extends FeatureNameState {}

class FeatureNameLoaded extends FeatureNameState {
  final int? count;

  FeatureNameLoaded({required this.count});
}

class FeatureNameError extends FeatureNameState {
  final Exception exception;
  FeatureNameError(this.exception);
}
