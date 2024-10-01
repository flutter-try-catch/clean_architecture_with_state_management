abstract class NewFeatureState {}

class NewFeatureInitial extends NewFeatureState {}

class NewFeatureLoading extends NewFeatureState {}

class NewFeatureLoaded extends NewFeatureState {}

class NewFeatureError extends NewFeatureState {
  final Exception exception;
  NewFeatureError({required this.exception});
}
      