import '../../domain/entities/new_feature.dart';

class NewFeatureModel extends NewFeature {
  const NewFeatureModel(
      {required String data})
      : super(data: data);

  NewFeatureModel copyWith({
    String? data,
  }) {
    return NewFeatureModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory NewFeatureModel.fromJson(Map<String, dynamic> json) => NewFeatureModel(
    data: json["data"],
  );
}

