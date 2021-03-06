import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:aston_math_application/ui/screens/home/homePage/home_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/settings_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videosTabPageCubit/videos_tab_page_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

//Where all dependencies are registered.
class Dependencies {
  GetIt _getIt = GetIt.instance;

  void setup() {
    _setupAnalytics();
    _setupRepositories();
    _setupUtils();
    _setupBlocs();
  }

  //Set up various different services and other useful utilities.
  void _setupUtils() {
    _getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    _getIt.registerLazySingleton<NotificationService>(() => NotificationService(FirebaseMessaging.instance));
    _getIt.registerSingleton<AuthenticationService>(AuthenticationService(FirebaseAuth.instance,_getIt.get<NotificationService>()));
    _getIt.registerLazySingleton<QuestionService>(() => QuestionService(
      repo: _getIt.get<UserDetailsRepository>(),
    ));
    //Cubit registered here to allow easy access of state from other pages.
    _getIt.registerLazySingleton<HomePageCubit>(() => HomePageCubit(
      repo: _getIt.get<UserDetailsRepository>(),
      secondaryRepo: _getIt.get<QuestionRepository>(),
      thirdRepo: _getIt.get<QuestionMapRepository>(),
      videosRepository: _getIt.get<VideosRepository>(),
      notificationService: _getIt.get<NotificationService>()
    ));
  }

  //All repositories which need to be registered.
  void _setupRepositories() {


    _getIt.registerFactory<UserDetailsRepository>(() => UserDetailsRepositoryImpl(
      _getIt.get<FirebaseFirestore>(),
      _getIt.get<AuthenticationService>(),
    ));

    _getIt.registerFactory<QuestionMapRepository>(() => QuestionMapRepositoryImpl(
      _getIt.get<FirebaseFirestore>(),
    ));

    _getIt.registerFactory<QuestionRepository>(() => QuestionRepositoryImpl(
      _getIt.get<FirebaseFirestore>(),
    ));

    _getIt.registerFactory<VideosRepository>(() => VideosRepositoryImpl(
      _getIt.get<FirebaseFirestore>(),
    ));
  }

  //All blocs which need to be registered
  void _setupBlocs() {
    _getIt.registerFactory<QuestionTabPageCubit>(() => QuestionTabPageCubit(
      repo: _getIt.get<QuestionMapRepository>(),
    ));

    _getIt.registerFactory<VideosTabPageCubit>(() => VideosTabPageCubit(
      repo: _getIt.get<VideosRepository>(),
    ));

    _getIt.registerFactory<QuestionDetailPageCubit>(() => QuestionDetailPageCubit(
      repo: _getIt.get<QuestionRepository>(),
    ));

    _getIt.registerFactory<SettingsTabPageCubit>(() => SettingsTabPageCubit(
      service: _getIt.get<NotificationService>(),
    ));


  }

  //Set Up Firebase Crashlytics.
  void _setupAnalytics() {
    _getIt.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
  }
}