import '../../domain/entities/test_provider.dart';

class TestProviderModel extends TestProvider {
  const TestProviderModel(
      {required String data})
      : super(data: data);

  TestProviderModel copyWith({
    String? data,
  }) {
    return TestProviderModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory TestProviderModel.fromJson(Map<String, dynamic> json) => TestProviderModel(
    data: json["data"],
  );
}

