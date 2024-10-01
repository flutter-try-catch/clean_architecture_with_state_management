import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/riverpod_name_provider.dart';



class RiverpodNameScreen extends ConsumerWidget {
  const RiverpodNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newFeatureProvider.notifier);
    return Scaffold(
      body: Placeholder(),
    );
  }
}
      