import 'dart:io';

import 'package:flutter/material.dart';

class OsWrapper extends StatelessWidget {
  const OsWrapper(
      {Key? key, required this.desktopWidget, required this.mobileWidget})
      : super(key: key);

  final Widget desktopWidget;
  final Widget mobileWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Platform.isMacOS ? desktopWidget : mobileWidget);
  }
}
