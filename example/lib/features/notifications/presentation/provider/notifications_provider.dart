import '../../domain/use_cases/notifications_use_case.dart';
import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsUseCase notificationsUseCase;
  NotificationsProvider({required this.notificationsUseCase}) {
    init();
  }

  void init() async {}
}
