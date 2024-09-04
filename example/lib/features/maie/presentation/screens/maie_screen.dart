import 'package:example/features/maie/presentation/provider/maie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../provider/maie_provider.dart';

// class MaieScreen extends StatefulWidget {
//   const MaieScreen({super.key});
//   @override
//   State<MaieScreen> createState() => _MaieState();
// }

class MaieScreen extends ConsumerWidget {
  const MaieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maieProvider);
    return Scaffold(
      body: Text('Maie:'),
    );
  }
}
