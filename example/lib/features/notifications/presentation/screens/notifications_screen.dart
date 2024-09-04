import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../provider/notifications_provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = "/notifications";
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<NotificationsProvider>(),
        child: Consumer<NotificationsProvider>(
          builder: (context, provider, child) {
            return const Scaffold(body: Placeholder());
          },
        ));
  }
}
