import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/response_models/currency_model.dart';
import 'package:equatable/equatable.dart';

class LatestRatesResponseModel extends ResponseModel {
  LatestRatesResponseModel({
    this.meta,
    this.data,
  });

  factory LatestRatesResponseModel.fromMap(Map<String, dynamic> json) =>
      LatestRatesResponseModel(
        meta: json['meta'] == null
            ? null
            : Meta.fromMap(json['meta'] as Map<String, dynamic>),
        data: Map.from(json['data'] as Map<String, dynamic>).map(
          (k, v) => MapEntry<String, CurrencyModel>(
            k as String,
            CurrencyModel.fromMap(v as Map<String, dynamic>),
          ),
        ),
      );

  final Meta? meta;
  final Map<String, CurrencyModel>? data;

  Map<String, dynamic> toMap() => {
        'meta': meta?.toMap(),
        'data': Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k as String, v.toMap())),
      };

  @override
  List<Object?> get props => [meta, data];
}

class Meta extends Equatable {
  const Meta({
    this.lastUpdatedAt,
  });

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        lastUpdatedAt: json['last_updated_at'] == null
            ? null
            : DateTime.parse(json['last_updated_at'] as String? ?? ''),
      );
  final DateTime? lastUpdatedAt;

  Map<String, dynamic> toMap() => {
        'last_updated_at': lastUpdatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [lastUpdatedAt];
}
