import 'package:aston_math_application/engine/model/video/video_topic.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videosTabPageCubit/videos_tab_page_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../util/drop_down_tiles/expandable_tile_videos.dart';
import '../../../../util/styles/CustomColors.dart';

class VideosTabPage extends StatefulWidget {
  @override
  _VideosTabPageState createState() => _VideosTabPageState();
}

class _VideosTabPageState extends State<VideosTabPage> {

  VideosTabPageCubit _bloc = GetIt.instance();
  List<VideoTopic>? _videos;



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
                          child: Icon(Icons.smart_display, color: Colors.white, size: 150,),
                          padding: EdgeInsets.fromLTRB(10,30,0,5)
                      ),
                      Container(
                          child: Text("videos_title", style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),).tr(),
                          padding: EdgeInsets.fromLTRB(10,100,20,5)
                      ),
                      Spacer()
                    ],
                  ),
                  color: CustomColors.BlueZodiac,
                ),
                BlocBuilder<VideosTabPageCubit, VideosTabPageState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if(state is VideosTabPageStateFailed) return Column(
                        children: [
                          SizedBox(height: 20,),
                          Text('An Error Occurred!', style: const TextStyle(fontSize: 20, fontFamily:"Asap", color: CustomColors.BlueZodiac)),
                          SizedBox(height: 10,),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: CustomColors.BlueZodiac,
                            ),
                            onPressed: () async {
                              await _bloc.getVideos();
                            },
                            child: const Text('Retry', style: const TextStyle(fontSize: 20, fontFamily:"Asap", color: Colors.white)),
                          )
                        ]);
                    if (state is VideosTabPageStateLoading) {
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                    if(state is VideosTabPageStateSuccess) {
                      _videos = state.videos;
                      return Container(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _videos!.length,
                          itemBuilder: (context, index) {
                            return ExpandableTileVideos(_videos![index]);
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