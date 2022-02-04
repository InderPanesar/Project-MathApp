import 'dart:collection';
import 'dart:math';

import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';


class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required this.repo, required this.secondaryRepo, required this.thirdRepo}) : super(HomePageState.loading()) {
    getAccountDetails();
  }

  UserDetailsRepository repo;
  QuestionRepository secondaryRepo;
  QuestionMapRepository thirdRepo;


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
      print("ERROR");
      emit(HomePageState.failed());
    } else {
      DateTime currentTime = Timestamp.now().toDate();
      DateTime serverTime = data.lastActive.toDate();
      final difference = currentTime.difference(serverTime).inDays;
      if(difference >= 1 && data.doneHomeQuiz) {
        data.lastActive = Timestamp.now();
        Map<String, String> topicsMap = await setNewDailyTasks(data.scores);
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
      else {
        data.questions.forEach((key, value) {
          print(key);
          print(value);
        });
        emit(HomePageState.success(data));
      }


    }
    return;
  }

  Future<Map<String, String>> setNewDailyTasks(Map<String, int> scores) async {
    final sorted = new SplayTreeMap<String,dynamic>.from(scores, (a, b) => scores[a]! > scores[b]! ? 1 : -1 );
    List<String> weakestCategories = [];
    sorted.forEach((key, value) {
      weakestCategories.add(key);
      if(weakestCategories.length == 4) return;
    });
    List<QuestionTopic> topics = [];
    try {
      topics = await thirdRepo.getQuestionTopics();
    }
    catch (e) {
      emit(HomePageState.failed());
    }

    Map<String, String> topicsMap = new Map();

    for(QuestionTopic questionTopic in topics) {
      if(weakestCategories.contains(questionTopic.name)) {
        final _random = new Random();
        String randomId = questionTopic.id[_random.nextInt(questionTopic.id.length)];
        topicsMap[questionTopic.name] = randomId;
      }
    }

    return topicsMap;
  }

  Future<List<Question>?> getIntroQuestions() async {
    List<Question>? data;
    try {
      data = await secondaryRepo.getQuestions("LzLJPpz8dkwFKYfDJNH7");
    } catch(e) {
      return null;
    }
    return data;
  }


}