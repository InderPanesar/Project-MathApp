import 'package:aston_math_application/engine/model/video/video_model.dart';

class VideoTopic {
  VideoTopic({required this.category, required this.videos});

  final String category;
  final List<VideoModel> videos;

}