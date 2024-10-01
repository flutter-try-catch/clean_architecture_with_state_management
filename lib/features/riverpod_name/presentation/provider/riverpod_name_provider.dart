import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/riverpod_name_use_case.dart';
import 'riverpod_name_state.dart';
import '../../inject_riverpod_name.dart';

final riverpodNameProvider = StateNotifierProvider<RiverpodNameProvider, RiverpodNameState>((ref) {
  return RiverpodNameProvider(riverpodNameUseCase: ref.read(riverpodNameUseCaseProvider));
});

class RiverpodNameProvider extends StateNotifier<RiverpodNameState> {

  final RiverpodNameUseCase riverpodNameUseCase;
  RiverpodNameProvider({required this.riverpodNameUseCase}) : super(RiverpodNameInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      