import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_flt/coins/models/models.dart';
import 'package:test_flt/constants/constants.dart';

class AssetsNotifier extends ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 5f1d1e8b2076940edce67a3f51cbcf3b46408b56737e4cb58e76a25862c65ac4',
      },
    ),
  );

  final List<Asset> _assets = [];
  bool _isLoading = false;
  bool _hasEndReached = false;

  List<Asset> get assets => _assets;
  bool get isLoading => _isLoading;
  bool get hasEndReached => _hasEndReached;

  Future<void> fetchAssets({int offset = 0, int limit = 20}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.assets,
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final results = response.data?['data'] as List<dynamic>;
        final loadedAssets = results
            .map((e) => Asset.fromJson(e as Map<String, dynamic>))
            .toList();

        _hasEndReached = loadedAssets.isEmpty;

        _assets.addAll(loadedAssets);
      }
    } catch (e) {
      debugPrint('Error fetching assets: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class CallbackDebouncer {
  CallbackDebouncer(this._delay);

  final Duration _delay;
  Timer? _timer;

  void call(VoidCallback callback) {
    if (_delay == Duration.zero) {
      callback();
    } else {
      _timer?.cancel();
      _timer = Timer(_delay, callback);
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
