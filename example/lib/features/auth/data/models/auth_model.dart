import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel(
      {required String data})
      : super(data: data);

  AuthModel copyWith({
    String? data,
  }) {
    return AuthModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    data: json["data"],
  );
}

