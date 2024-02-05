import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel(
      {required String data})
      : super(data: data);

  ProfileModel copyWith({
    String? data,
  }) {
    return ProfileModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: json["data"],
  );
}

