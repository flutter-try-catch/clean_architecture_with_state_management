
import '../../domain/entities/ahmed.dart';

class AhmedModel extends Ahmed {
  AhmedModel(
      {required String data})
      : super(data: data);

  AhmedModel copyWith({
    String? data,
  }) {
    return AhmedModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory AhmedModel.fromJson(Map<String, dynamic> json) => AhmedModel(
    data: json["data"],
  );
}

