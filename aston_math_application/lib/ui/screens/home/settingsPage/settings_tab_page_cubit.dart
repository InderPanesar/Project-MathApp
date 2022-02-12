import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/util/shared_preferences_keys.dart';
import 'package:get_it/get_it.dart';

import '../../../../engine/model/UserDetails/UserDetails.dart';
import '../../../../engine/repository/user_details_repository.dart';

class SettingsTabPageCubit {

  NotificationService service;
  UserDetailsRepository detailsRepository = GetIt.I();

  SettingsTabPageCubit({required this.service});

  bool isPushNotificationsActive()  {
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