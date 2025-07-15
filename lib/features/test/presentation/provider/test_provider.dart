import '../../domain/use_cases/test_use_case.dart';
import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {

  final TestUseCase testUseCase;
  TestProvider({required this.testUseCase}) {
    init();
  }

  void init() async {

  }
}

      