import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../provider/test_provider_provider.dart';

class TestProviderScreen extends StatefulWidget {
  const TestProviderScreen({super.key});
  @override
  State<TestProviderScreen> createState() => _TestProviderState();
}

class _TestProviderState extends State<TestProviderScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<TestProviderProvider>(),
        child: Consumer<TestProviderProvider>(
          builder: (context, provider, child) {
            return const Scaffold(
              body: Placeholder()
            );
          },
        ));
  }
}
      