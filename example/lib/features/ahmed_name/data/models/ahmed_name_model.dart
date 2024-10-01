import '../../domain/entities/ahmed_name.dart';

class AhmedNameModel extends AhmedName {
  const AhmedNameModel(
      {required String data})
      : super(data: data);

  AhmedNameModel copyWith({
    String? data,
  }) {
    return AhmedNameModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory AhmedNameModel.fromJson(Map<String, dynamic> json) => AhmedNameModel(
    data: json["data"],
  );
}

