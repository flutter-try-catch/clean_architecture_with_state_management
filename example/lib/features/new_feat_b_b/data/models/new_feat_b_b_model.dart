import '../../domain/entities/new_feat_b_b.dart';

class NewFeatBBModel extends NewFeatBB {
  const NewFeatBBModel(
      {required String data})
      : super(data: data);

  NewFeatBBModel copyWith({
    String? data,
  }) {
    return NewFeatBBModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory NewFeatBBModel.fromJson(Map<String, dynamic> json) => NewFeatBBModel(
    data: json["data"],
  );
}

