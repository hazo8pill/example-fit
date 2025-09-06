import 'package:flutter/material.dart';
import 'package:test_flt/coins/notifiers/notifiers.dart';
import 'package:test_flt/coins/view/coin_list_item.dart';
import 'package:test_flt/coins/view/cons_list_view.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoinsView();
  }
}

class CoinsView extends StatefulWidget {
  const CoinsView({super.key});

  @override
  State<CoinsView> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView> {
  final _notifier = AssetsNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _notifier,
        builder: (context, value) {
          return CoinsListView(
            hasEndReached: _notifier.hasEndReached,
            isLoading: _notifier.isLoading,
            fetchMore: () =>
                _notifier.fetchAssets(offset: _notifier.assets.length),
            itemCount: _notifier.assets.length,
            itemBuilder: (context, index) =>
                CoinListItem(asset: _notifier.assets[index]),
          );
        },
      ),
    );
  }
}
