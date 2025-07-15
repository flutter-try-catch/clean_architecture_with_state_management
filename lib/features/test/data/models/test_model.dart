import '../../domain/entities/test.dart';

class TestModel extends Test {
  const TestModel(
      {required String data})
      : super(data: data);

  TestModel copyWith({
    String? data,
  }) {
    return TestModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    data: json["data"],
  );
}

