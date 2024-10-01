import '../../domain/entities/test_name.dart';

class TestNameModel extends TestName {
  const TestNameModel(
      {required String data})
      : super(data: data);

  TestNameModel copyWith({
    String? data,
  }) {
    return TestNameModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory TestNameModel.fromJson(Map<String, dynamic> json) => TestNameModel(
    data: json["data"],
  );
}

