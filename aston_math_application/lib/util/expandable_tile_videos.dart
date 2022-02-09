import 'package:aston_math_application/engine/model/video/VideoTopic.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../ui/screens/home/videosPage/videoPageModal/video_tab_page_modal.dart';


class ExpandableTileVideos extends StatefulWidget {

  final VideoTopic topic;

  ExpandableTileVideos(this.topic);

  @override
  _ExpandableTileVideoState createState() => _ExpandableTileVideoState(topic);

}

class _ExpandableTileVideoState extends State<ExpandableTileVideos>  {

  bool isExpanded = false;
  BorderRadius topRadius = BorderRadius.circular(10.0);
  double rotation = 0;

  VideoTopic topic;

  _ExpandableTileVideoState(this.topic);

  void navigateToPage(BuildContext context, VideoModel topic, int arrayValue) {
    print('Card tapped. Code: ' + topic.attributes.first);
    String url = topic.attributes.first;
    if(url != null) {
      url = YoutubePlayer.convertUrlToId(url)!;
    }
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showMaterialModalBottomSheet(
        useRootNavigator: true,
        expand: false,
        shape: RoundedRectangleBorder(  // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        enableDrag: false,
        context: context,
        builder: (context) =>
            VideoTabPageModal(video: topic, controller: _controller)
    );

  }




  Widget getDropDown(BuildContext context, VideoTopic topic) {
    return Visibility(
        visible: isExpanded,
        child: Column(
            children: <Widget> [
              for(int i = 0; i < topic.videos.length; i++)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: ((i+1) == topic.videos.length) ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.circular(0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                  color: Colors.red,
                  child: InkWell(
                    splashColor: Colors.red.withAlpha(30),
                    onTap: () {
                      navigateToPage(context, topic.videos[i], i);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Row(
                            children: [
                              Text( topic.videos[i].title, style: TextStyle(fontSize: 20, color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ]
        )
    );
  }

  Widget build(BuildContext context) {
    if(topic.videos.length == 1) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: topRadius,
        ),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        color: Colors.red,
        child: InkWell(
          splashColor: Colors.red.withAlpha(30),
          onTap: () {
            navigateToPage(context, topic.videos.first, 0);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Row(
                  children: [
                    Text( topic.videos.first.title, style: TextStyle(fontSize: 20, color: Colors.white),),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    else {
      return Column(

        children: [
          SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: topRadius,
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            color: Colors.red,
            child: InkWell(
              splashColor: Colors.red.withAlpha(30),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  (isExpanded) ? topRadius = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : topRadius = BorderRadius.circular(10);
                  (isExpanded) ? rotation = 180 : rotation = 0;

                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Row(
                      children: [
                        Text( topic.category, style: TextStyle(fontSize: 20, color: Colors.white),),
                        Spacer(),
                        new RotationTransition(
                            turns: new AlwaysStoppedAnimation(rotation / 360),
                            child: Container(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                "assets/images/ic_chevron-down.svg",
                                color: Colors.white,
                              ),
                            )
                        )


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          getDropDown(context, topic),
          SizedBox(height: 5),
        ],
      );
    }

  }

}