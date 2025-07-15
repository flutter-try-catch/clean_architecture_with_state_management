import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../provider/test_provider.dart';

class TestScreen extends StatefulWidget {
  static const routeName = "/test";
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestState();
}

class _TestState extends State<TestScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<TestProvider>(),
        child: Consumer<TestProvider>(
          builder: (context, provider, child) {
            return const Scaffold(
              body: Placeholder()
            );
          },
        ));
  }
}
      