import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  final FirebaseMessaging firebaseMessaging;
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  NotificationService(this.firebaseMessaging);

  NotificationSettings? settings;

  bool notifcationsActive = false;

  Future<void> subscribeToTopic() async {
    await firebaseMessaging.subscribeToTopic('DailyQuizNotification');
    notifcationsActive = true;
  }
  Future<void> unsubscribeFromTopic() async {
    await firebaseMessaging.unsubscribeFromTopic('DailyQuizNotification');
    notifcationsActive = false;
  }

  Future initialiseNotificationService(bool? pushNotificationActive) async {

    if (Platform.isIOS) {
      settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
    else if (Platform.isAndroid) {
      settings = await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );
    }

    if(settings!.authorizationStatus == AuthorizationStatus.authorized) {
      if(pushNotificationActive != null) {
        notifcationsActive = pushNotificationActive;
      }
      else {
        notifcationsActive = true;
      }
      if(notifcationsActive)  {
        await firebaseMessaging.subscribeToTopic('DailyQuizNotification');
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);


        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          var androidNotification = new AndroidNotificationDetails(
              channel.id, channel.name, channelDescription: channel.description,
              priority: Priority.max, importance: Importance.max);
          var iOSNotification = new IOSNotificationDetails();
          var platform = new NotificationDetails(android: androidNotification, iOS: iOSNotification);

          var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
          var initializationSettingsIOS = IOSInitializationSettings();
          var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
          await flutterLocalNotificationsPlugin.initialize(initializationSettings);

          if(notification != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                platform
            );
          }
        });
      }

    } else {
      notifcationsActive = false;
    }
  }

  Future<void> updateNotificationStatus() async{
    notifcationsActive = !notifcationsActive;
    if(notifcationsActive) {
      await subscribeToTopic();
    }
    else {
      await unsubscribeFromTopic();
    }
  }




}