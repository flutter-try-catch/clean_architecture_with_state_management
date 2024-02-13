import '../../domain/entities/new_feat_b.dart';

class NewFeatBModel extends NewFeatB {
  const NewFeatBModel(
      {required String data})
      : super(data: data);

  NewFeatBModel copyWith({
    String? data,
  }) {
    return NewFeatBModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory NewFeatBModel.fromJson(Map<String, dynamic> json) => NewFeatBModel(
    data: json["data"],
  );
}

