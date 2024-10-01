import '../../domain/entities/riverpod_name.dart';

class RiverpodNameModel extends RiverpodName {
  const RiverpodNameModel(
      {required String data})
      : super(data: data);

  RiverpodNameModel copyWith({
    String? data,
  }) {
    return RiverpodNameModel(
      data: data ?? this.data  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  factory RiverpodNameModel.fromJson(Map<String, dynamic> json) => RiverpodNameModel(
    data: json["data"],
  );
}

