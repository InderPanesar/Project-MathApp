import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:aston_math_application/ui/screens/home/homePage/home_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videosTabPageCubit/videos_tab_page_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';

class Dependencies {
  GetIt _getIt = GetIt.instance;

  void setup() {
    _setupAPIs();
    _setupAnalytics();
    _setupRepositories();
    _setupUtils();
    _setupBlocs();
  }

  void _setupAPIs() {
    _getIt.registerLazySingleton<Dio>((){
      final Dio dio = Dio();
      dio.options.baseUrl = "https://ghibliapi.herokuapp.com";
      return dio;
    }, instanceName: "authorised");

  }

  void _setupUtils() {
      //_getIt.registerSingleton<NavigationService>(NavigationService());
    _getIt.registerSingleton<AuthenticationService>(AuthenticationService(FirebaseAuth.instance));
    _getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    _getIt.registerLazySingleton<QuestionService>(() => QuestionService(
      repo: _getIt.get<UserDetailsRepository>(),
    ));
    _getIt.registerLazySingleton<HomePageCubit>(() => HomePageCubit(
      repo: _getIt.get<UserDetailsRepository>(),
      secondaryRepo: _getIt.get<QuestionRepository>(),
      thirdRepo: _getIt.get<QuestionMapRepository>(),
      videosRepository: _getIt.get<VideosRepository>(),
    ));
  }

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


  }

  void _setupAnalytics() {
    _getIt.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
  }
}