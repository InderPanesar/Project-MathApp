import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/model/video/VideoTopic.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/settings_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videosTabPageCubit/videos_tab_page_cubit.dart';
import 'package:flutter_local_notifications/src/platform_specifics/android/notification_channel.dart';
import 'package:get_it/get_it.dart';
import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/ui/screens/home/homePage/home_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DependenciesMock {
  GetIt _getIt = GetIt.instance;


  void setup() {
    _setupRepositories();
    _setupUtils();
    _setupBlocs();
  }

  void _setupRepositories() {
    _getIt.registerFactory<UserDetailsRepository>(() => new UserDetailsRepositoryMock());
    _getIt.registerFactory<QuestionMapRepository>(() => new QuestionMapRepositoryMock());
    _getIt.registerFactory<QuestionRepository>(() => QuestionRepositoryMock());
    _getIt.registerFactory<VideosRepository>(() => VideosRepositoryMock());
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
    _getIt.registerFactory<SettingsTabPageCubit>(() => SettingsTabPageCubit(
      service: _getIt.get<NotificationService>(),
    ));
  }

  void _setupUtils() {
    //_getIt.registerSingleton<NavigationService>(NavigationService());
    _getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    _getIt.registerLazySingleton<NotificationService>(() => NotificationServiceMock());
    _getIt.registerSingleton<AuthenticationService>(AuthenticationServiceMock());
    _getIt.registerLazySingleton<QuestionService>(() => QuestionService(
      repo: _getIt.get<UserDetailsRepository>(),
    ));
    _getIt.registerLazySingleton<HomePageCubit>(() => HomePageCubit(
        repo: _getIt.get<UserDetailsRepository>(),
        secondaryRepo: _getIt.get<QuestionRepository>(),
        thirdRepo: _getIt.get<QuestionMapRepository>(),
        videosRepository: _getIt.get<VideosRepository>(),
        notificationService: _getIt.get<NotificationService>()
    ));
  }


}

class UserDetailsRepositoryMock implements UserDetailsRepository {
  UserDetails details = new UserDetails(name: "", age: "", doneHomeQuiz: false, scores: new Map(), lastActive: Timestamp.fromDate(new DateTime(2000)), questions: new Map(), recommendedVideo: [], notificationsActive: true);

  @override
  Future<void> addUserDetails(UserDetails details) async {
    this.details = details;
  }

  @override
  Future<UserDetails?> getUserDetails() {
    return Future.value(details);
  }

}

class QuestionMapRepositoryMock implements QuestionMapRepository {
  @override
  Future<List<QuestionTopic>> getQuestionTopics() {
    List<QuestionTopic> topics = [];
    topics.add(QuestionTopic(name: "QUESTION 1", id: ["1"]));
    topics.add(QuestionTopic(name: "QUESTION 2", id: ["2"]));
    return Future.value(topics);
  }

  @override
  Future<List<Question>> getQuestions(String id) {
    List<Question> questions = [];
    questions.add(Question(answer: '0', question: "Question", preQuestion: "", description: "DESCRIPTION", afterQuestion: "", characters: []));
    return Future.value(questions);
  }
}

class QuestionRepositoryMock implements QuestionRepository {
  @override
  Future<List<Question>> getQuestions(String id) {
    List<Question> questions = [];
    questions.add(Question(answer: '0', question: "Question", preQuestion: "", description: "DESCRIPTION", afterQuestion: "", characters: []));
    return Future.value(questions);
  }
}

class VideosRepositoryMock implements VideosRepository {
  @override
  Future<List<VideoTopic>> getVideos() {
    List<VideoTopic> topics = [];
    topics.add(VideoTopic(category: "VIDEOS", videos: [new VideoModel(title: 'VIDEOS 1', attributes: ["https://www.youtube.com/watch?v=93YGZ6q_ucA, description"])]));
    topics.add(VideoTopic(category: "VIDEOS", videos: [new VideoModel(title: 'VIDEOS 2', attributes: ["https://www.youtube.com/watch?v=93YGZ6q_ucA, description"])]));
    return Future.value(topics);
  }

}

class AuthenticationServiceMock implements AuthenticationService {
  @override
  // TODO: implement authStateChanges
  Stream<User?> get authStateChanges => throw UnimplementedError();

  @override
  Future<void> createUserDetails(bool notificationActive) async {}

  @override
  FirebaseAuth getAuth() {
    // TODO: implement getAuth
    throw UnimplementedError();
  }

  @override
  Future<String> resetPassword(String email) {
    if(validateEmailForMocks(email)) {
      return Future.value("Email Sent");
    }
    return Future.value("Error");
  }

  @override
  Future<String> signIn(String email, String password) {
    if(validateEmailForMocks(email) && password.length > 0) {
      return Future.value("Signed in");
    }
    return Future.value("Error");

  }

  @override
  Future<void> signOut() async {}

  @override
  Future<String> signUp(String email, String password, bool notificationsActive) {
    if(validateEmailForMocks(email) && password.length > 0) {
      return Future.value("Signed up");
    }
    return Future.value("Error");
  }

  bool validateEmailForMocks(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  }

}

class NotificationServiceMock implements NotificationService {
  @override
  bool notifcationsActive = true;

  @override
  NotificationSettings? settings;

  @override
  AndroidNotificationChannel get channel => throw UnimplementedError();

  @override
  FirebaseMessaging get firebaseMessaging => throw UnimplementedError();

  @override
  Future<void> initialiseNotificationService(bool? pushNotificationActive) async {
    notifcationsActive = true;
  }

  @override
  Future<void> subscribeToTopic() async {
    notifcationsActive = true;
  }

  @override
  Future<void> unsubscribeFromTopic() async {
    notifcationsActive = false;
  }

  @override
  Future<void> updateNotificationStatus() async {
    notifcationsActive = !notifcationsActive;
  }

}

