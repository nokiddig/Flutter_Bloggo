import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingSV{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

}