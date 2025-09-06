import 'package:test_flt/constants/constants.dart';

class Asset {
  Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      priceUsd: double.tryParse(json['priceUsd'] as String) ?? 0,
    );
  }

  final String id;
  final String symbol;
  final String name;
  final double priceUsd;

  String get price => currencyFormat.format(priceUsd);
}
