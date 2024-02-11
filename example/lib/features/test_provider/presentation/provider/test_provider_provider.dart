import 'package:example/features/test_provider/domain/use_cases/test_provider_use_case.dart';
import 'package:flutter/material.dart';

class TestProviderProvider extends ChangeNotifier {

  final TestProviderUseCase testProviderUseCase;
  TestProviderProvider({required this.testProviderUseCase}) {
    init();
  }

  void init() async {

  }
}

      