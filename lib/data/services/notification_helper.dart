import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User Granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User permission granted provisional");
    } else {
      log("User deny permission");
    }

    // RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    // if (message != null) {
    //   messageHandler(message);
    // }
    // FirebaseMessaging.onMessage.listen(messageHandler);
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }
}