import 'dart:collection';
import 'dart:math';

import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../engine/model/video/VideoTopic.dart';
import '../../../../engine/repository/videos_repository.dart';

part 'home_page_state.dart';


class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required this.repo, required this.secondaryRepo, required this.thirdRepo, required this.videosRepository, required this.notificationService}) : super(HomePageState.loading()) {
    getAccountDetails();
  }

  UserDetailsRepository repo;
  QuestionRepository secondaryRepo;
  QuestionMapRepository thirdRepo;
  VideosRepository videosRepository;
  NotificationService notificationService;


  Future<void> getAccountDetails() async {
    emit(HomePageState.loading());
    UserDetails? data;
    try {
      data = await repo.getUserDetails();
    } catch(e) {
      print(e.toString());
      emit(HomePageState.failed());
      return;
    }



    if(data == null){
      emit(HomePageState.failed());
    } else {
      notificationService.notifcationsActive = data.notificationsActive;
      await notificationService.initialiseNotificationService(data.notificationsActive);

      DateTime currentTime = Timestamp.now().toDate();
      DateTime serverTime = data.lastActive.toDate();
      final difference = currentTime.difference(serverTime).inDays;
      if(difference >= 1 && data.doneHomeQuiz) {
        await addDailyTask(data);
      }
      else if (data.doneHomeQuiz && data.questions.length == 0) {
        await addDailyTask(data);
      }
      else {
        emit(HomePageState.success(data));
      }


    }
    return;
  }

  Future <void> addDailyTask(UserDetails data) async {
    DateTime currentDateTime = DateTime.now();
    currentDateTime = new DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 9, 0, 0, 0, 0);
    data.lastActive = Timestamp.fromDate(currentDateTime);
    Map<String, List<String>> topicsMap = await setNewDailyTasks(data.scores);
    var details = await setDailyVideoRecommendation(topicsMap, data);

    if(details == null) {
      emit(HomePageState.failed());
      return;
    }
    else {
      data = details;
    }
    if(topicsMap.isEmpty) {
      emit(HomePageState.failed());
      return;
    }
    else {
      data.questions = topicsMap;
      try {
        await repo.addUserDetails(data);
      }
      catch(e) {
        emit(HomePageState.failed());
        return;
      }
      emit(HomePageState.success(data));
    }

  }

  Future<Map<String, List<String>>> setNewDailyTasks(Map<String, int> scores) async {
    final sorted = new SplayTreeMap<String,dynamic>.from(scores, (a, b) => scores[a]! > scores[b]! ? 1 : -1 );
    List<String> weakestCategories = [];
    sorted.forEach((key, value) {
      if(weakestCategories.length == 4) return;
      weakestCategories.add(key);
    });

    List<QuestionTopic> topics = [];
    try {
      topics = await thirdRepo.getQuestionTopics();
    }
    catch (e) {
      emit(HomePageState.failed());
    }


    Map<String, List<String>> topicsMap = new Map();



    for(QuestionTopic questionTopic in topics) {
      if(weakestCategories.contains(questionTopic.name)) {
        final _random = new Random();
        String randomId = questionTopic.id[_random.nextInt(questionTopic.id.length)];
        List<String> values = [randomId, "false"];
        topicsMap[questionTopic.name] = values;
      }
    }

    return topicsMap;
  }

  Future<UserDetails?> setDailyVideoRecommendation(Map<String, List<String>> scores, UserDetails data) async {

    List<VideoTopic> videos = [];
    try {
      videos = await videosRepository.getVideos();
    } catch (e) {
      emit(HomePageState.failed());
      return null;
    }


    for(VideoTopic topic in videos ) {
      for(String weakestCategory in scores.keys.toList()) {
        if(topic.category == weakestCategory) {
          data.recommendedVideo = [
            topic.videos.first.title,
            topic.videos.first.attributes.first,
            topic.videos.first.attributes.last,
          ];
          return data;
        }
      }
    }

    return data;

  }

  Future<List<Question>?> getIntroQuestions() async {
    List<Question>? data;
    try {
      data = await secondaryRepo.getQuestions("initialisation_quiz");
    } catch(e) {
      return null;
    }
    return data;
  }

  Future<List<Question>?> getQuestions(String id) async {
    List<Question>? data;
    try {
      data = await secondaryRepo.getQuestions(id);
    } catch(e) {
      return null;
    }
    return data;
  }

  double getPercentageDone(List<String> values)  {
    return 0.0;
  }


}