import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ioc_demo/presentation/navigation/push_messaging/push_message.dart';

class PushDataMapper {
  PushMessage mapPayload(String payload) {
    final Map<String, dynamic> json =
        (jsonDecode(payload) as Map<String, dynamic>).cast<String, dynamic>();
    return PushMessage.fromJson(json);
  }

  PushMessage map(RemoteMessage message) {
    return PushMessage(
      message.data['uri'] as String?,
      message.data['type'] as String?,
      message.notification?.title,
      message.notification?.body,
      message.data['context_id'] as String?,
    );
  }
}
