import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:ioc_demo/injector.dart';
import 'package:ioc_demo/presentation/login/login_screen.dart';
import 'package:ioc_demo/presentation/scope_widget.dart';

void main() {
  initApp();
}

Future<void> initApp() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final IOC ioc = IOC.appScope();
    runApp(App(scope: ioc));
  }, (Object error, StackTrace stackTrace) async {
    Fimber.e('main error', ex: error, stacktrace: stackTrace);
  });
}

class App extends StatelessWidget {
  const App({Key? key, required this.scope}) : super(key: key);
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeWidget(
      scope: scope,
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
