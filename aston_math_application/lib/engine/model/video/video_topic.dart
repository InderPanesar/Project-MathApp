import 'package:aston_math_application/engine/model/video/video_model.dart';

//Video Topic defined from Firebase DB Model
class VideoTopic {
  VideoTopic({required this.category, required this.videos});

  final String category;
  final List<VideoModel> videos;

}