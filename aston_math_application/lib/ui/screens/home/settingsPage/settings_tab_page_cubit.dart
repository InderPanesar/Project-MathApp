import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/util/shared_preferences_keys.dart';
import 'package:get_it/get_it.dart';

import '../../../../engine/model/UserDetails/UserDetails.dart';
import '../../../../engine/repository/user_details_repository.dart';

class SettingsTabPageCubit {

  NotificationService service;
  UserDetailsRepository detailsRepository = GetIt.I();
  bool pushNotificationsActive = false;

  SettingsTabPageCubit({required this.service});

  bool isPushNotificationsActive()  {
    print("PUSH NOTIFICATIONS: " + service.notifcationsActive.toString());
    return service.notifcationsActive;
  }

  Future<void> updateNotificationStatus() async {
    await service.updateNotificationStatus();
    UserDetails? details = await detailsRepository.getUserDetails();
    if(details != null) {
      details.notificationsActive = service.notifcationsActive;
      await detailsRepository.addUserDetails(details);
    }

  }
}