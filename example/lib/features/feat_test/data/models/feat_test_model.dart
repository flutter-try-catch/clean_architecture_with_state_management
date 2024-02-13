import '../../domain/entities/feat_test.dart';

class FeatTestModel extends FeatTest {
  const FeatTestModel(
      {required String data})
      : super(data: data);

  FeatTestModel copyWith({
    String? data,
  }) {
    return FeatTestModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory FeatTestModel.fromJson(Map<String, dynamic> json) => FeatTestModel(
    data: json["data"],
  );
}

