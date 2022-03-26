import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTabPageModal extends StatefulWidget {
  final YoutubePlayerController controller;
  final VideoModel video;

  VideoTabPageModal(this.controller, this.video);

  @override
  _VideosTabPageModelState createState() => _VideosTabPageModelState(this.controller, this.video);
}

class _VideosTabPageModelState extends State<VideoTabPageModal> {
  YoutubePlayerController controller;
  VideoModel video;

  _VideosTabPageModelState(this.controller, this.video);

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp
    ]);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void resetRotation(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //Made This Widget Root So Fullscreen works for any modal.
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.close, size: 30,)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 12),
                  child: Text(video.title, style: TextStyle(fontSize: 24),),
                ),
                player,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(video.attributes.last, style: TextStyle(fontSize: 16, fontFamily: "AsapCondensed"),),
                ),
              ],
            ),

          );
        }
    );


  }

}

