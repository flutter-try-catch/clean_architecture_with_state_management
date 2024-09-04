import '../../domain/entities/notifications.dart';

class NotificationsModel extends Notifications {
  const NotificationsModel({required String data}) : super(data: data);

  NotificationsModel copyWith({
    String? data,
  }) {
    return NotificationsModel(
      data: data ?? this.data ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data: json["data"],
      );
}
