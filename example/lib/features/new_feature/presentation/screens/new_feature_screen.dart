import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/new_feature_provider.dart';



class NewFeatureScreen extends ConsumerWidget {
  const NewFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newFeatureProvider.notifier);
    return Scaffold(
      body: Placeholder(),
    );
  }
}
      