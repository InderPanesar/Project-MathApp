import 'dart:io' show Platform;

import 'package:aston_math_application/util/shared_preferences_keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesKeys.PushNotifications, true);
    notifcationsActive = true;
  }
  Future<void> unsubscribeFromTopic() async {
    await firebaseMessaging.unsubscribeFromTopic('DailyQuizNotification');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesKeys.PushNotifications, false);
    notifcationsActive = false;
  }

  Future initialiseNotificationService() async {
    final prefs = await SharedPreferences.getInstance();

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
      bool? sharedPreferencesValue = prefs.getBool(SharedPreferencesKeys.PushNotifications);
      if(sharedPreferencesValue != null) {
        notifcationsActive = sharedPreferencesValue;
      }
      else {
        await prefs.setBool(SharedPreferencesKeys.PushNotifications, true);
        notifcationsActive = true;
      }
      if(notifcationsActive) await firebaseMessaging.subscribeToTopic('DailyQuizNotification');
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);


      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        print("message recieved");
        if(notification != null) {
          if(android != null) {
            print("HIT!");
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    icon: "@mipmap/ic_launcher",
                  ),
                ));
          }
        }
      });

    } else {
      await prefs.setBool(SharedPreferencesKeys.PushNotifications, false);
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