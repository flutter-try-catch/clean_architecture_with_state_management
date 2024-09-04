import 'package:example/injection_container.dart';

import '../../domain/use_cases/maie_use_case.dart';
import 'maie_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maieProvider = StateNotifierProvider<MaieProvider, MaieState>(
  (ref) {
    return MaieProvider();
  },
);

class MaieProvider extends StateNotifier<MaieState> {
  // final MaieUseCase maieUseCase;
  MaieProvider() : super(MaieInitial()) {
    init();
  }

  void init() async {}
}
