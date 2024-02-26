import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ioc_demo/configurations/firebase_config.dart';
import 'package:ioc_demo/configurations/flavoring/flavor.dart';
import 'package:ioc_demo/constants/string_constants.dart';
import 'package:ioc_demo/injector.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/helpers/navigation_service.dart';
import 'package:ioc_demo/presentation/navigation/push_messaging/push_data_mapper.dart';
import 'package:ioc_demo/presentation/navigation/push_messaging/push_messaging_widget.dart';
import 'package:ioc_demo/presentation/scope_widget.dart';
import 'package:ioc_demo/presentation/splash/splash_screen.dart';
import 'package:ioc_demo/presentation/themes/theme.dart';
import 'package:ioc_demo/utilities%20/utility.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  initApp();
}

Future<void> initApp() async {
  runZonedGuarded<Future<dynamic>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions,
    );
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final String? token = await firebaseMessaging.getToken();
    Utility.showLog('FCM: $token');
    await setFlavor();
    final IOC ioc = IOC.appScope();
    runApp(
      MyApp(scope: ioc),
    );
  }, (Object error, StackTrace stackTrace) async {
    Utility.showLog('main error:$error');
    Utility.showLog('main error:$stackTrace');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.scope}) : super(key: key);
  final IOC scope;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late final IOC scope;

  @override
  void initState() {
    super.initState();
    scope = widget.scope;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    return ScopeWidget(
      scope: scope,
      child: Provider<AppNavigator>(
        create: (BuildContext context) => AppNavigator(),
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.androidTheme(),
          title: StringConstants.appName,
          home: PushMessagingWidget(
            appNavigator: AppNavigator(),
            pushDataMapper: PushDataMapper(),
            child: _buildApp(),
          ),
        ),
      ),
    );
  }

  Widget _buildApp() {
    Widget mainPage = const SplashScreen();
    if (debugBanner.isNotEmpty) {
      mainPage = Banner(
        message: debugBanner,
        location: BannerLocation.topStart,
        child: mainPage,
      );
    }
    return mainPage;
  }
}
