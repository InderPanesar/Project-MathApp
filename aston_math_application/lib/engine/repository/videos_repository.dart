import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/model/video/VideoTopic.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class VideosRepository {
  Future<List<VideoTopic>> getUserDetails();
}

class VideosRepositoryImpl implements VideosRepository {

  final FirebaseFirestore _firebaseFirestore;
  VideosRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<VideoTopic>> getUserDetails() async {
    Map<String, dynamic>? details;
    List<VideoTopic> models = [];

    await _firebaseFirestore.collection('videos').doc("vn4nQuAGVj2Z2NRtG8vd").get().then((value) {
      if(value.exists) {
        details = new Map<String, dynamic>.from(value["videos"]);
        Map<String, Map<String, dynamic>> _valuesTemp = {};

        for(String name in details!.keys.toList()) {
          _valuesTemp[name] = new Map<String, dynamic>.from(details![name]);
        }

        for(String category in _valuesTemp.keys.toList()) {
          List<VideoModel> videosList = [];
          Map<String, dynamic> videos = {};
          videos = new Map<String, dynamic>.from(_valuesTemp[category]!);
          for(String videoTitle in videos.keys.toList()) {
            List<String> attributes = new List<String>.from(videos[videoTitle]);
            videosList.add(new VideoModel(title: videoTitle, attributes: attributes));
          }
          models.add(new VideoTopic(category: category, videos: videosList));
        }
      }
    });

    return models;

  }

}