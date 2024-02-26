import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyBOpojQfUNuXI8O2dCSsX75E4YZh3uLjwg',
        appId: '1:954062933440:ios:22455b5d1b497e45d40c25',
        messagingSenderId: '954062933440',
        projectId: 'iocstructuredemo',
        iosBundleId: 'com.xxxxxxx.app.dev',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:954062933440:android:92d36d0634dc53d9d40c25',
        apiKey: 'AIzaSyBqEke0I9cEnr0gHeyLPAz4ZPvJ5HcUXY0',
        projectId: 'iocstructuredemo',
        messagingSenderId: '954062933440',
      );
    }
  }
}
