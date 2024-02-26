import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ioc_demo/configurations/connectivity_config/connectivity_helper.dart';
import 'package:rxdart/rxdart.dart';

typedef LoadMore = Future<dynamic> Function();

typedef OnLoadMore = void Function();

typedef ItemCount = int Function();

typedef HasMore = bool Function();

typedef OnLoadMoreFinished = void Function();

/// A list view that can be used for incrementally,
///  loading items when the user scrolls.
/// This is an extension of the ListView widget that,
///  uses the ListView.builder constructor.
class LoadMoreListView extends StatefulWidget {
  const LoadMoreListView({
    Key? key,
    required this.hasMore,
    required this.loadMore,
    this.loadMoreOffsetFromBottom = 0,
    this.keys,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.onRefresh,
    required this.itemBuilder,
    required this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.cacheExtent,
    this.onLoadMore,
    this.onLoadMoreFinished,
    this.paddingBottom = 10.0,
    this.paddingLeft = 10.0,
    this.paddingRight = 10.0,
    this.paddingTop = 10.0,
    this.isAddRefresh = true,
    this.refreshIndicatorColor = Colors.blue,
    this.loadMoreIndicatorColor = Colors.blue,
    this.refreshIndicatorBackGroundColor = Colors.white,
    this.isUseExpanded = true,
    this.separator,
  }) : super(key: key);

  /// A callback that indicates if the collection associated with,
  ///  the ListView has more items that should be loaded
  final HasMore hasMore;

  /// A callback to an asynchronous function that would load more items
  final LoadMore loadMore;

  /// Determines when the list view should attempt to load more items,
  ///  based on of the index of the item is scrolling into view
  /// This is relative to the bottom of the list and has a default value ,
  ///  that it loads when the last item within the list view scrolls into view.
  /// As an example, setting this to 1 would attempt to load more items,
  ///  when the second last item within the list view scrolls into view
  final int? loadMoreOffsetFromBottom;
  final Key? keys;
  final Axis? scrollDirection;
  final bool? reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final IndexedWidgetBuilder? itemBuilder;
  final ItemCount? itemCount;
  final bool? addAutomaticKeepAlives;
  final bool? addRepaintBoundaries;
  final double? cacheExtent;
  final Function()? onRefresh;
  final Color? refreshIndicatorColor;
  final Color? refreshIndicatorBackGroundColor;
  final Color loadMoreIndicatorColor;

  /// A callback that is triggered when more items are being loaded
  final OnLoadMore? onLoadMore;

  /// A callback that is triggered when items have finished being loaded
  final OnLoadMoreFinished? onLoadMoreFinished;

  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final bool isAddRefresh;
  final bool isUseExpanded;
  final Widget? separator;

  @override
  LoadMoreListViewState createState() {
    return LoadMoreListViewState();
  }
}

class LoadMoreListViewState extends State<LoadMoreListView> {
  LoadMoreListViewState() {
    _loadingMoreStream =
        _loadingMoreSubject.switchMap((bool shouldLoadMore) => loadMore());
  }

  bool _loadingMore = false;
  final PublishSubject<bool> _loadingMoreSubject = PublishSubject<bool>();
  late Stream<bool> _loadingMoreStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _loadingMoreStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: widget.paddingBottom,
            top: widget.paddingTop,
            right: widget.paddingRight,
            left: widget.paddingLeft,
          ),
          child: Column(
            children: <Widget>[
              if (widget.isUseExpanded)
                Expanded(
                  child: widget.isAddRefresh
                      ? RefreshIndicator(
                          color: widget.refreshIndicatorColor,
                          backgroundColor:
                              widget.refreshIndicatorBackGroundColor,
                          onRefresh: () async {
                            if (await ConnectivityHelper()
                                .checkConnectivity()) {
                              return widget.onRefresh!();
                            } else {
                              return;
                            }
                          },
                          child: getList(),
                        )
                      : getList(),
                )
              else
                widget.isAddRefresh
                    ? RefreshIndicator(
                        color: widget.refreshIndicatorColor,
                        backgroundColor: widget.refreshIndicatorBackGroundColor,
                        onRefresh: () async {
                          if (await ConnectivityHelper().checkConnectivity()) {
                            return widget.onRefresh!();
                          } else {
                            return;
                          }
                        },
                        child: getList(),
                      )
                    : getList(),
              if (_loadingMore)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.loadMoreIndicatorColor,
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
        );
      },
    );
  }

  Stream<bool> loadMore() async* {
    yield _loadingMore;
    if (widget.onLoadMore != null) {
      widget.onLoadMore!;
    }
    await widget.loadMore();
    _loadingMore = false;
    yield _loadingMore;
    if (widget.onLoadMoreFinished != null) {
      widget.onLoadMoreFinished!;
    }
  }

  @override
  void dispose() {
    _loadingMoreSubject.close();
    super.dispose();
  }

  Widget getList() {
    return ListView.separated(
      key: widget.keys,
      scrollDirection: widget.scrollDirection!,
      reverse: widget.reverse!,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap!,
      padding: widget.padding,
      separatorBuilder: (BuildContext itemBuilderContext, int index) {
        return widget.separator ?? const SizedBox.shrink();
      },
      itemBuilder: (BuildContext itemBuilderContext, int index) {
        if (!_loadingMore &&
            index ==
                widget.itemCount!() - widget.loadMoreOffsetFromBottom! - 1 &&
            widget.hasMore()) {
          _loadingMore = true;
          _loadingMoreSubject.add(true);
        }
        return widget.itemBuilder!(itemBuilderContext, index);
      },
      itemCount: widget.itemCount!(),
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives!,
      addRepaintBoundaries: widget.addRepaintBoundaries!,
      cacheExtent: widget.cacheExtent,
    );
  }
}
