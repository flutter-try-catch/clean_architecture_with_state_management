import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/test_provider.dart';
import '../provider/test_state.dart';

class TestScreen extends ConsumerWidget {
  static const String routeName = '/test';
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testProvider);

    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            if (state is TestInitial) {
              return const Text('Initial State');
            } else if (state is TestLoading) {
              return const Text('Loading State');
            } else if (state is TestLoaded) {
              return const Text('Loaded State');
            }
            return const Text('Unknown State');
          },
        ),
      ),
    );
  }
}
