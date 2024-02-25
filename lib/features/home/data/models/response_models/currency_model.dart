import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  const CurrencyModel({
    required this.code,
    required this.value,
  });

  factory CurrencyModel.fromMap(Map<String, dynamic> json) => CurrencyModel(
        code: json['code'] as String? ?? '',
        value: (json['value'] as num?)?.toDouble() ?? 0,
      );

  final String code;
  final double value;

  Map<String, dynamic> toMap() => {
        'code': code,
        'value': value,
      };

  @override
  List<Object?> get props => [
        code,
        value,
      ];
}
