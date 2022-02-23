import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTabPageModal extends StatelessWidget {
  // This widget is the root of your application.
  final YoutubePlayerController controller;
  final VideoModel video;

  VideoTabPageModal({required this.controller, required this.video });

  @override
  Widget build(BuildContext context) {
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