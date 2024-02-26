import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/widgets/custom_widgets/custom_app_bar.dart';

/// AppScaffold
class AppScaffold extends StatefulWidget {
  /// Constructor
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.themeData,
    this.systemUiOverlayStyleIOS,
    this.backgroundColor = Palette.whiteColor,
    this.appBarTitle,
    this.isShowAppBar = false,
    this.isShowBackButton = false,
    this.isHtmlFormTitle = false,
    this.actionsWidgets,
    this.leftActionWidget,
    this.backButtonFunction,
    this.isCenterTitle = false,
    this.showBanner = true,
  });

  /// Scaffold Body
  final Widget body;

  ///AppBar
  final PreferredSizeWidget? appBar;

  /// SystemUiOverlayStyle
  final SystemUiOverlayStyle? systemUiOverlayStyleIOS;

  /// BackGround Color
  final Color backgroundColor;

  final ThemeData? themeData;

  final bool isShowBackButton;

  final bool isShowAppBar;

  final bool isHtmlFormTitle;

  final String? appBarTitle;

  final Function()? backButtonFunction;

  final List<Widget>? actionsWidgets;

  final bool isCenterTitle;

  final bool showBanner;

  final Widget? leftActionWidget;

  @override
  AppScaffoldState createState() => AppScaffoldState();

  /// AppScaffoldState
  static AppScaffoldState of(BuildContext context, {bool nullOk = false}) {
    final AppScaffoldState? result =
        context.findAncestorStateOfType<AppScaffoldState>();
    if (nullOk || result != null) {
      return result!;
    }
    throw 'AppScaffold.of() called with a context '
        'that does not contain a AppScaffold.';
  }
}

/// AppScaffoldState
class AppScaffoldState extends State<AppScaffold> {
  final StreamController<List<AppSnackBar>> _controller =
      StreamController<List<AppSnackBar>>();

  /// isOffline
  bool isOffline = false;

  @override
  Widget build(BuildContext context) {
    Widget child;
    //TODO: Platform condition is not working in WEB
    // if (widget.appBar == null && Platform.isIOS) {
    //   child = AnnotatedRegion<SystemUiOverlayStyle>(
    //     value: widget.systemUiOverlayStyleIOS ??
    //         _themeSystemUiOverlayStyle(context),
    //     child: widget.body,
    //   );
    // } else {
    //   child = widget.body;
    // }
    child = widget.body;

    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: widget.appBar ??
              (widget.isShowAppBar
                  ? customAppBar(
                      context: context,
                      isHtmlFormTitle: widget.isHtmlFormTitle,
                      isShowBackButton: widget.isShowBackButton,
                      title: widget.appBarTitle,
                      backButtonFunction: widget.backButtonFunction,
                      actionWidgets: widget.actionsWidgets,
                      leftActionWidget: widget.leftActionWidget,
                      isCenterTitle: widget.isCenterTitle,
                    )
                  : null),
          backgroundColor: widget.backgroundColor,
          body: Stack(
            children: <Widget>[
              AbsorbPointer(
                absorbing: isOffline,
                child: child,
              ),
              //ConnectivityContainerWidget(widget.themeData),
              StreamBuilder<List<AppSnackBar>>(
                stream: _controller.stream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<AppSnackBar>> snapshot,
                ) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: snapshot.data ?? <AppSnackBar>[],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

/*SystemUiOverlayStyle _themeSystemUiOverlayStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SystemUiOverlayStyle overlayStyle =
        theme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return overlayStyle;
  }*/
}

/// Class AppSnackBar
///
/// USed for showing SnackBar using AppSnackBar bar severity
class AppSnackBar extends StatefulWidget {
  /// Constructor
  const AppSnackBar({
    super.key,
    required this.content,
    required this.action,
    required this.actionCallback,
    required this.bgColor,
    required this.priority,
    required this.permanent,
  });

  /// priorityHigh
  static const int priorityHigh = 0;

  /// priorityNormal
  static const int priorityNormal = 1;

  /// priorityJ
  static const int priorityJ = 2;

  /// minHeight
  static const double minHeight = 32.0;

  /// content
  final Widget content;

  /// action
  final Widget action;

  /// actionCallback
  final VoidCallback actionCallback;

  /// priority
  final int priority;

  /// permanent
  final bool permanent;

  final Color bgColor;

  @override
  // ignore: library_private_types_in_public_api
  _AppSnackBarState createState() => _AppSnackBarState();
}

class _AppSnackBarState extends State<AppSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _prepareAnimation();
    _controller.forward();

    if (!widget.permanent) {
      _timer = Timer(
        const Duration(seconds: 4),
        () => _controller.reverse(),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSnackBar.minHeight),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.bgColor,
        ),
        margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6),
              child: DefaultTextStyle(
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                child: widget.content,
              ),
            ),
            _buildAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    return Positioned(
      right: 0,
      child: InkWell(
        onTap: widget.actionCallback,
        child: widget.action,
      ),
    );
  }

  void _prepareAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }
}
