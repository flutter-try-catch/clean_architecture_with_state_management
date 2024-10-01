import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/ahmed_name_use_case.dart';
import 'ahmed_name_state.dart';
import '../../inject_ahmed_name.dart';

final ahmedNameProvider = StateNotifierProvider<AhmedNameProvider, AhmedNameState>((ref) {
  return AhmedNameProvider(ahmedNameUseCase: ref.read(ahmedNameUseCaseProvider));
});

class AhmedNameProvider extends StateNotifier<AhmedNameState> {

  final AhmedNameUseCase ahmedNameUseCase;
  AhmedNameProvider({required this.ahmedNameUseCase}) : super(AhmedNameInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      