import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:get_it/get_it.dart';

import '../../../../engine/model/user_details/user_details.dart';
import '../../../../engine/repository/user_details_repository.dart';

class SettingsTabPageCubit {

  NotificationService service;
  UserDetailsRepository detailsRepository = GetIt.I();
  bool pushNotificationsActive = false;

  SettingsTabPageCubit({required this.service});

  bool isPushNotificationsActive()  {
    print("PUSH NOTIFICATIONS: " + service.notificationsActive.toString());
    return service.notificationsActive;
  }

  Future<void> updateNotificationStatus() async {
    await service.updateNotificationStatus();
    UserDetails? details = await detailsRepository.getUserDetails();
    if(details != null) {
      details.notificationsActive = service.notificationsActive;
      await detailsRepository.addUserDetails(details);
    }

  }
}