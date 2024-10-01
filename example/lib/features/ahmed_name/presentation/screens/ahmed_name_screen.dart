import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/ahmed_name_provider.dart';



class AhmedNameScreen extends ConsumerWidget {
  const AhmedNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ahmedNameProvider.notifier);
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
      