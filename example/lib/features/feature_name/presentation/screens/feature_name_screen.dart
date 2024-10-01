import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/feature_name_provider.dart';

class FeatureNameScreen extends ConsumerWidget {
  const FeatureNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featureNameProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FeatureName')),
      body: Consumer(builder: (_, ref, __) {
        if (state is FeatureNameLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeatureNameLoaded) {
          return Center(child: Text('Data loaded successfully ${state.count}'));
        } else if (state is FeatureNameError) {
          return Center(child: Text('Error: ${state.exception}'));
        } else {
          return const Center(child: Text('Press the button to load data'));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(featureNameProvider.notifier).fetchData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

//   Widget _buildBody(FeatureNameState state) {
//     if (state is FeatureNameLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is FeatureNameLoaded) {
//       return const Center(child: Text('Data loaded successfully'));
//     } else if (state is FeatureNameError) {
//       return Center(child: Text('Error: ${state.exception}'));
//     } else {
//       return const Center(child: Text('Press the button to load data'));
//     }
//   }
// }
}
