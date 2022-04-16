//Video Model defined from Firebase DB Model
class VideoModel {
  VideoModel({required this.title, required this.attributes});

  final String title;
  final List<String> attributes;

}