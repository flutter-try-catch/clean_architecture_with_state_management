import '../../domain/use_cases/splash_use_case.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final SplashUseCase splashUseCase;
  SplashProvider({required this.splashUseCase}) {
    init();
  }

  void init() async {}
}
