import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/test_use_case.dart';
import 'test_state.dart';
import '../../inject_test.dart';

final testProvider = StateNotifierProvider<TestProvider, TestState>((ref) {
  return TestProvider(testUseCase: ref.read(testUseCaseProvider));
});

class TestProvider extends StateNotifier<TestState> {

  final TestUseCase testUseCase;
  TestProvider({required this.testUseCase}) : super(TestInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      