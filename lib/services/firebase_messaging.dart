// import 'dart:io';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
//
// class FirebaseMessagingSV{
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initialize() async {
//     AwesomeNotifications().initialize('resource://drawable/laucher_icon', [
//       NotificationChannel(
//         channelKey: 'CHANNEL_ID_01',
//         channelName: 'Notification',
//         importance: NotificationImportance.Max,
//         vibrationPattern: highVibrationPattern,
//         channelDescription: 'Demo notification'
//       )
//     ]);
//     AwesomeNotifications().isNotificationAllowed()
//         .then((isAllowed) {
//           if (!isAllowed) {
//             AwesomeNotifications().requestPermissionToSendNotifications();
//           }
//     });
//   }
//
//
//   void configurePushNotifications(BuildContext context) async {
//     initialize();
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: false,
//     );
//
//     // if (Platform.isIOS) {
//     //   g
//     // }
//     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//
//     FirebaseMessaging.onMessage.listen((message) async {
//       print("${message.notification!.body}");
//       if (message.notification != null){
//         createOrderNotification(
//           title: message.notification!.title,
//           body: message.notification!.body
//         );
//       }
//     });
//   }
//
//   Future<void> createOrderNotification({String? title, String? body}) async {
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(id: 0, channelKey: 'CHANNEL_ID_01',
//           title: title,
//           body: body
//         )
//     );
//   }
//
//   // void eventListenerCallback(BuildContext context){
//   //   AwesomeNotifications().setListeners(
//   //       onActionReceivedMethod: )
//   // }
// }
//
// // @param("vm:entry-point")
// Future<dynamic> myBackgroundMessageHandler(RemoteMessage remoteMessage) async {
//   await Firebase.initializeApp();
// }
//
// class NotificationController{
//   // @param("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//     ReceivedNotification receivedNotification) async {
//
//   }
// }