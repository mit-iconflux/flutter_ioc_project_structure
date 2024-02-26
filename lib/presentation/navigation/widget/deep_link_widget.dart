import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/app_routes.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_model.dart';
import 'package:ioc_demo/utilities%20/utility.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkWidget extends StatefulWidget {
  const DeepLinkWidget({
    Key? key,
    required this.child,
    required this.appNavigator,
  }) : super(key: key);
  final Widget child;
  final AppNavigator appNavigator;

  @override
  DeepLinkWidgetState createState() => DeepLinkWidgetState();
}

class DeepLinkWidgetState extends State<DeepLinkWidget> {
  @visibleForTesting
  StreamSubscription<String?>? subscription;

  @override
  void initState() {
    _handleInitialLink();
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _handleInitialLink() async {
    final String? initialLink = await getInitialLink();
    Utility.showLog('initialLink: $initialLink');
    subscription = linkStream.listen((String? link) {
      Utility.showLog('newLink: $link');
      if (link != null &&
          link.isNotEmpty &&
          (initialLink != null && link.startsWith(initialLink))) {
        _handleLink(link);
      }
    });
  }

  void _handleLink(String link) {
    Utility.showLog('handleLink: $link');
    final int startOfHostPart = link.indexOf(':/');
    final String updatedLink = link.substring(startOfHostPart + 2);
    widget.appNavigator.push(AppRoutes.cta(CTAModel.deepLink(updatedLink)));
  }
}
