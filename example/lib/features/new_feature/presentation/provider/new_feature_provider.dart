import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/new_feature_use_case.dart';
import 'new_feature_state.dart';
import '../../inject_new_feature.dart';

final newFeatureProvider = StateNotifierProvider<NewFeatureProvider, NewFeatureState>((ref) {
  return NewFeatureProvider(newFeatureUseCase: ref.read(newFeatureUseCaseProvider));
});

class NewFeatureProvider extends StateNotifier<NewFeatureState> {

  final NewFeatureUseCase newFeatureUseCase;
  NewFeatureProvider({required this.newFeatureUseCase}) : super(NewFeatureInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      