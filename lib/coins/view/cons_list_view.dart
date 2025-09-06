import 'package:flutter/material.dart';
import 'package:test_flt/coins/notifiers/asset_notifier.dart';

class CoinsListView extends StatefulWidget {
  const CoinsListView({
    required this.hasEndReached,
    required this.isLoading,
    required this.fetchMore,
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  final bool hasEndReached;
  final bool isLoading;
  final VoidCallback fetchMore;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<CoinsListView> createState() => _CoinsListViewState();
}

class _CoinsListViewState extends State<CoinsListView> {
  final debounce = CallbackDebouncer(const Duration(milliseconds: 200));

  int? _lastFetchedIndex;

  @override
  void initState() {
    super.initState();

    attemptFetch();
  }

  void attemptFetch() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debounce(widget.fetchMore);
    });
  }

  void onBuiltLast(int lastItemIndex) {
    if (_lastFetchedIndex != lastItemIndex) {
      _lastFetchedIndex = lastItemIndex;
      attemptFetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastItemIndex = widget.itemCount - 1;

    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        if (!widget.isLoading &&
            !widget.hasEndReached &&
            index == lastItemIndex) {
          onBuiltLast(lastItemIndex);
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}
