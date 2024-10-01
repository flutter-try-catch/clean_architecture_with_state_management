import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../provider/your_feature_name_provider.dart';

class YourFeatureNameScreen extends StatefulWidget {
  static const routeName = "/your_feature_name";
  const YourFeatureNameScreen({super.key});
  @override
  State<YourFeatureNameScreen> createState() => _YourFeatureNameState();
}

class _YourFeatureNameState extends State<YourFeatureNameScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<YourFeatureNameProvider>(),
        child: Consumer<YourFeatureNameProvider>(
          builder: (context, provider, child) {
            return const Scaffold(
              body: Placeholder()
            );
          },
        ));
  }
}
      