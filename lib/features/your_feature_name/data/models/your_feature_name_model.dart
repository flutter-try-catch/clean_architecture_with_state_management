import '../../domain/entities/your_feature_name.dart';

class YourFeatureNameModel extends YourFeatureName {
  const YourFeatureNameModel(
      {required String data})
      : super(data: data);

  YourFeatureNameModel copyWith({
    String? data,
  }) {
    return YourFeatureNameModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory YourFeatureNameModel.fromJson(Map<String, dynamic> json) => YourFeatureNameModel(
    data: json["data"],
  );
}

