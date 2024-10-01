import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/test_name_provider.dart';



class TestNameScreen extends ConsumerWidget {
  const TestNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testNameProvider.notifier);
    return Scaffold(
      body: Placeholder(),
    );
  }
}
      