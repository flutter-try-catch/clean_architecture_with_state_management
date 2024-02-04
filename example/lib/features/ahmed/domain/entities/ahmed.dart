import 'package:equatable/equatable.dart';
class Ahmed extends Equatable {
  final String? data;

  const Ahmed({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
