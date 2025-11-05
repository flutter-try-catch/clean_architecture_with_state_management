import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required String data})
      : super(data: data);

  UserModel copyWith({
    String? data,
  }) {
    return UserModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: json["data"],
  );
}

