import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';
import '../provider/auth_state.dart';

class AuthScreen extends ConsumerWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            if (state is AuthInitial) {
              return const Text('Initial State');
            } else if (state is AuthLoading) {
              return const Text('Loading State');
            } else if (state is AuthLoaded) {
              return const Text('Loaded State');
            }
            return const Text('Unknown State');
          },
        ),
      ),
    );
  }
}
