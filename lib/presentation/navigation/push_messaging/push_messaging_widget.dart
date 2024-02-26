import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/app_routes.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_model.dart';
import 'package:ioc_demo/presentation/navigation/push_messaging/push_data_mapper.dart';
import 'package:ioc_demo/presentation/navigation/push_messaging/push_message.dart';
import 'package:ioc_demo/utilities%20/utility.dart';

class PushMessagingWidget extends StatefulWidget {
  const PushMessagingWidget({
    Key? key,
    required this.appNavigator,
    required this.pushDataMapper,
    required this.child,
  }) : super(key: key);
  final AppNavigator appNavigator;
  final Widget child;

  final PushDataMapper pushDataMapper;

  @override
  PushMessagingWidgetState createState() => PushMessagingWidgetState();
}

class PushMessagingWidgetState extends State<PushMessagingWidget> {
  late FlutterLocalNotificationsPlugin _localNotifications;
  late AndroidNotificationChannel _channel;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _localNotifications = FlutterLocalNotificationsPlugin();

    _channel = const AndroidNotificationChannel(
      //TODO: Add channel id and channel name
      '1', // id
      'channel1', // title
      importance: Importance.max,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) {
        Utility.showLog('local notification received: $payload');
        if (payload != null) {
          debugPrint('notification payload: $payload');
          final PushMessage pushData =
              widget.pushDataMapper.mapPayload(payload);
          _handleLocalNotification(pushData);
        }
      },
    );

    Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse,
    ) async {
      final PushMessage push = widget.pushDataMapper.mapPayload(
        notificationResponse.payload.toString(),
      );
      Utility.showLog('push: $push');
      final String? uri = push.uri;
      Utility.showLog('uri: $uri');
      if (uri != null && uri.isNotEmpty) {
        widget.appNavigator.push(AppRoutes.cta(CTAModel.deepLink(uri)));
      }
    }

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    _firebaseMessaging.onTokenRefresh.listen((String updatedToken) {
      Utility.showLog('FCM token refreshed: $updatedToken');
      if (updatedToken.isNotEmpty) {
        // widget.userInteractor.setDeviceToken(updatedToken);
      }
    });

    handlePushNotificationPermissionAndToken();

    // Message listener will call when app is in running state
    // It will fire local notification in the app
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        Utility.showLog('onMessage $message');
        final PushMessage pushData = widget.pushDataMapper.map(message);
        Utility.showLog('onMessage $pushData');
        await _showLocalNotification(pushData);
      } catch (e) {
        Utility.showLog('push handling error: $e');
      }
    });

    // When app is in running mode and
    // user click the local notification then callback will be here
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Utility.showLog('OnMessage Tap Initially:  ${message.data}');

      debugPrint('notification payload: $message');
      final PushMessage pushData = widget.pushDataMapper.map(message);
      _handleLocalNotification(pushData);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _showLocalNotification(PushMessage pushMessage) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _localNotifications.show(
      101,
      pushMessage.title,
      pushMessage.body,
      platformChannelSpecifics,
      payload: jsonEncode(pushMessage.toJson()),
    );
    return;
  }

  void _handleLocalNotification(PushMessage push) {
    Utility.showLog('push: $push');
    final String? uri = push.uri;
    Utility.showLog('uri: $uri');
    if (uri != null && uri.isNotEmpty) {
      widget.appNavigator.push(AppRoutes.cta(CTAModel.deepLink(uri)));
    }
  }

  Future<void> handlePushNotificationPermissionAndToken() async {
    //Creating notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    //Set configuration for receive notification
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    String? fcmToken;
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await _firebaseMessaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        fcmToken = await _firebaseMessaging.getAPNSToken();
      }
    } else {
      fcmToken = await _firebaseMessaging.getToken();
    }
    Utility.showLog('FCM token : $fcmToken');
  }
}
