import '../../domain/entities/feature_name.dart';

class FeatureNameModel extends FeatureName {
  const FeatureNameModel({required String data}) : super(data: data);

  FeatureNameModel copyWith({
    String? data,
  }) {
    return FeatureNameModel(
      data: data ?? this.data ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };

  factory FeatureNameModel.fromJson(Map<String, dynamic> json) =>
      FeatureNameModel(
        data: json["data"],
      );
}
