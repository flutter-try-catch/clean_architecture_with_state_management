import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/test_name_use_case.dart';
import 'test_name_state.dart';
import '../../inject_test_name.dart';

final testNameProvider = StateNotifierProvider<TestNameProvider, TestNameState>((ref) {
  return TestNameProvider(testNameUseCase: ref.read(testNameUseCaseProvider));
});

class TestNameProvider extends StateNotifier<TestNameState> {

  final TestNameUseCase testNameUseCase;
  TestNameProvider({required this.testNameUseCase}) : super(TestNameInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      