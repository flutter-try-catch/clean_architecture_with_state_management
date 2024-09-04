import '../../domain/entities/maie.dart';

class MaieModel extends Maie {
  const MaieModel({required String data}) : super(data: data);

  MaieModel copyWith({
    String? data,
  }) {
    return MaieModel(
      data: data ?? this.data ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };

  factory MaieModel.fromJson(Map<String, dynamic> json) => MaieModel(
        data: json["data"],
      );
}
