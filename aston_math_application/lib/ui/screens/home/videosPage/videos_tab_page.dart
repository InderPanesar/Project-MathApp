import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videoPageModal/video_tab_page_modal.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videosTabPageCubit/videos_tab_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosTabPage extends StatefulWidget {
  @override
  _VideosTabPageState createState() => _VideosTabPageState();
}

class _VideosTabPageState extends State<VideosTabPage> {

  VideosTabPageCubit _bloc = GetIt.instance();
  List<VideoModel>? _videos;



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text("Videos", style: TextStyle(fontSize: 32, color: Colors.white),),
                          padding: EdgeInsets.fromLTRB(20,60,20,40)
                      ),
                      Spacer()
                    ],
                  ),
                  color: Colors.red,
                ),
                BlocBuilder<VideosTabPageCubit, VideosTabPageState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if(state is VideosTabPageStateFailed) return Spacer(); //ToDo: Implement Error State
                    if (state is VideosTabPageStateLoading) {
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                    if(state is VideosTabPageStateSuccess) {
                      _videos = state.videos;
                      return Container(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _videos!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              color: Colors.red,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Card tapped. Code: ' + _videos![index].url);
                                  String url = _videos![index].url;
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
                                    VideoTabPageModal(video: _videos![index], controller: _controller)
                                  );

                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Row(
                                        children: [
                                          Text(_videos![index].title, style: TextStyle(fontSize: 20, color: Colors.white),),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    else return Spacer();

                  },

                )
              ]
          )
      ),
    );
  }
}