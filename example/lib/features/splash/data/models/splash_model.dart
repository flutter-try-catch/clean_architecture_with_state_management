import '../../domain/entities/splash.dart';

class SplashModel extends Splash {
  const SplashModel({required String data}) : super(data: data);

  SplashModel copyWith({
    String? data,
  }) {
    return SplashModel(
      data: data ?? this.data ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };

  factory SplashModel.fromJson(Map<String, dynamic> json) => SplashModel(
        data: json["data"],
      );
}
