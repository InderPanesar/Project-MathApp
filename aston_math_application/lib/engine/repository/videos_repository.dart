import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class VideosRepository {
  Future<List<VideoModel>> getUserDetails();
}

class VideosRepositoryImpl implements VideosRepository {

  final FirebaseFirestore _firebaseFirestore;
  VideosRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<VideoModel>> getUserDetails() async {
    Map<String, dynamic>? details;
    List<VideoModel> models = [];
    await _firebaseFirestore.collection('videos').doc("vn4nQuAGVj2Z2NRtG8vd").get().then((value) {
      if(value.exists) {
        details = new Map<String, dynamic>.from(value["videos"]);
        var newList = details!.keys.toList();
        for(String key in newList) {
          models.add(VideoModel(
            title: key,
            url: details![key][0],
            descriptions: details![key][1]
          ));
        }

      }
    });

    return models;

  }

}