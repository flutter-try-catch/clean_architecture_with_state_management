import '../../domain/use_cases/your_feature_name_use_case.dart';
import 'package:flutter/material.dart';

class YourFeatureNameProvider extends ChangeNotifier {

  final YourFeatureNameUseCase yourFeatureNameUseCase;
  YourFeatureNameProvider({required this.yourFeatureNameUseCase}) {
    init();
  }

  void init() async {

  }
}

      