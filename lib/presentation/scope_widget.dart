import 'package:flutter/material.dart';
import 'package:ioc_demo/injector.dart';
import 'package:provider/provider.dart';

class ScopeWidget extends StatelessWidget {
  const ScopeWidget({Key? key, this.child, required this.scope})
      : super(key: key);

  final Widget? child;
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return Provider<IOC>(
      key: key,
      create: (BuildContext context) => scope,
      dispose: (BuildContext context, IOC value) => value.dispose(),
      child: child ?? Container(),
    );
  }
}
