import 'package:equatable/equatable.dart';

class GoldPriceResponseModel extends Equatable {
  final int timestamp;
  final String metal;
  final String currency;
  final String exchange;
  final String symbol;
  final int openTime;
  final double price;
  final double ch;
  final double ask;
  final double bid;
  final double? priceGram24K;
  final double? priceGram22K;
  final double? priceGram21K;
  final double? priceGram20K;
  final double? priceGram18K;
  final double? priceGram16K;
  final double? priceGram14K;
  final double? priceGram10K;

  GoldPriceResponseModel({
    required this.timestamp,
    required this.metal,
    required this.currency,
    required this.exchange,
    required this.symbol,
    required this.openTime,
    required this.price,
    required this.ch,
    required this.ask,
    required this.bid,
    required this.priceGram24K,
    required this.priceGram22K,
    required this.priceGram21K,
    required this.priceGram20K,
    required this.priceGram18K,
    required this.priceGram16K,
    required this.priceGram14K,
    required this.priceGram10K,
  });

  factory GoldPriceResponseModel.fromMap(Map<String, dynamic> json) =>
      GoldPriceResponseModel(
        timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
        metal: (json['metal'] as String?) ?? '',
        currency: (json['currency'] as String?) ?? '',
        exchange: (json['exchange'] as String?) ?? '',
        symbol: (json['symbol'] as String?) ?? '',
        openTime: (json['open_time'] as int?) ?? 0,
        price: (json['price'] as num?)?.toDouble() ?? 0,
        ch: (json['ch'] as num?)?.toDouble() ?? 0,
        ask: (json['ask'] as num?)?.toDouble() ?? 0,
        bid: (json['bid'] as num?)?.toDouble() ?? 0,
        priceGram24K: (json['price_gram_24k'] as num?)?.toDouble(),
        priceGram22K: (json['price_gram_22k'] as num?)?.toDouble(),
        priceGram21K: (json['price_gram_21k'] as num?)?.toDouble(),
        priceGram20K: (json['price_gram_20k'] as num?)?.toDouble(),
        priceGram18K: (json['price_gram_18k'] as num?)?.toDouble(),
        priceGram16K: (json['price_gram_16k'] as num?)?.toDouble(),
        priceGram14K: (json['price_gram_14k'] as num?)?.toDouble(),
        priceGram10K: (json['price_gram_10k'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() =>
      {
        'timestamp': timestamp,
        'metal': metal,
        'currency': currency,
        'exchange': exchange,
        'symbol': symbol,
        'open_time': openTime,
        'price': price,
        'ch': ch,
        'ask': ask,
        'bid': bid,
        'price_gram_24k': priceGram24K,
        'price_gram_22k': priceGram22K,
        'price_gram_21k': priceGram21K,
        'price_gram_20k': priceGram20K,
        'price_gram_18k': priceGram18K,
        'price_gram_16k': priceGram16K,
        'price_gram_14k': priceGram14K,
        'price_gram_10k': priceGram10K,
      };

  @override
  List<Object?> get props =>
      [
        timestamp,
        metal,
        currency,
        exchange,
        symbol,
        openTime,
        price,
        ch,
        ask,
        bid,
        priceGram24K,
        priceGram22K,
        priceGram21K,
        priceGram20K,
        priceGram18K,
        priceGram16K,
        priceGram14K,
        priceGram10K,
      ];
}
