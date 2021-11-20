import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/comms/api/example_api.dart';
import 'package:aston_math_application/engine/repository/example_repository.dart';
import 'package:aston_math_application/ui/screens/authentication/login/exampleCubit/example_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';

class Dependencies {
  GetIt _getIt = GetIt.instance;

  void setup() {
    _setupAPIs();
    _setupAnalytics();
    _setupUtils();
    _setupRepositories();
    _setupBlocs();
  }

  void _setupAPIs() {
    _getIt.registerLazySingleton<Dio>((){
      final Dio dio = Dio();
      dio.options.baseUrl = "https://ghibliapi.herokuapp.com";
      return dio;
    }, instanceName: "authorised");

    _getIt.registerLazySingleton<ExampleApi>(() => ExampleApi(_getIt.get<Dio>(instanceName: "authorised")));
  }

  void _setupUtils() {
      //_getIt.registerSingleton<NavigationService>(NavigationService());
    _getIt.registerSingleton<AuthenticationService>(AuthenticationService(FirebaseAuth.instance));
  }

  void _setupRepositories() {
    _getIt.registerFactory<ExampleRepository>(() => ExampleRepositoryImpl(
      _getIt.get<ExampleApi>(),
    ));
  }

  void _setupBlocs() {
    _getIt.registerFactory<ExampleCubit>(() => ExampleCubit(
      repo: _getIt.get<ExampleRepository>(),
    ));
  }

  void _setupAnalytics() {
    _getIt.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
  }
}