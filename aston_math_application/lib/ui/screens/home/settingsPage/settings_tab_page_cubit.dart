import 'package:aston_math_application/engine/notifications/notification_service.dart';

class SettingsTabPageCubit {

  NotificationService service;
  SettingsTabPageCubit({required this.service});

  bool isPushNotificationsActive()  {
    return service.notifcationsActive;
  }

  Future<void> updateNotificationStatus() {
    return service.updateNotificationStatus();
  }
}