import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/helpers/scroll_physic.dart';

class ScrollToCloseWidget extends StatefulWidget {
  const ScrollToCloseWidget({Key? key, required this.child, this.onClose})
      : super(key: key);
  final Widget child;
  final VoidCallback? onClose;

  @override
  ScrollToCloseWidgetState createState() => ScrollToCloseWidgetState();
}

class ScrollToCloseWidgetState extends State<ScrollToCloseWidget> {
  final ScrollController _scrollController = ScrollController();

  static const int _kMaxOverScrollOffset = 35;
  static const int _kClosablePositionDelta = 5;
  double _scale = 1;
  double _startScrollPosition = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_startScrollPosition > _kClosablePositionDelta &&
          _startScrollPosition <
              (_scrollController.position.maxScrollExtent -
                  _kClosablePositionDelta)) {
        return;
      }

      final double maxScrollExtent = _scrollController.position.maxScrollExtent;
      final double pixels = _scrollController.position.pixels;

      double overScrollOffset = 0;
      if (pixels < 0) {
        // overScroll up
        overScrollOffset = pixels.abs();
      } else if (pixels > maxScrollExtent) {
        // overScroll down
        overScrollOffset = pixels - maxScrollExtent;
      }

      double dragFraction;
      double scale;

      if (overScrollOffset > 0) {
        dragFraction =
            math.log(1 + (overScrollOffset / _kMaxOverScrollOffset)) /
                math.log10e;
        scale = 1 - ((1 - 0.98) * dragFraction);
      } else {
        scale = 1;
      }

      if (_scale != scale) {
        setState(() {
          _scale = scale;
        });
      }

      if (overScrollOffset > _kMaxOverScrollOffset &&
          //ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          _scrollController.position.activity is BallisticScrollActivity) {
        internalPop();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          _startScrollPosition = notification.metrics.pixels;
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics2(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Transform.scale(
          scale: _scale,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  bool _isPoped = false;

  void internalPop() {
    if (mounted && !_isPoped) {
      widget.onClose!();
      _isPoped = true;
      Navigator.pop(context);
    }
  }
}
