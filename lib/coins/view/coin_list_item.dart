import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_flt/coins/models/models.dart';

class CoinListItem extends StatefulWidget {
  const CoinListItem({required this.asset, super.key});

  final Asset asset;

  @override
  State<CoinListItem> createState() => _CoinListItemState();
}

class _CoinListItemState extends State<CoinListItem> {
  final _random = Random();

  late final Color _color = Color.fromARGB(
    255,
    _random.nextInt(256),
    _random.nextInt(256),
    _random.nextInt(256),
  );

  late final _textStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Color(0xFF17171A),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(width: 16),
          Text(widget.asset.symbol, style: _textStyle),
          const Spacer(),
          Text(widget.asset.price, style: _textStyle),
        ],
      ),
    );
  }
}
