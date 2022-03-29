import 'package:aston_math_application/engine/model/video/video_topic.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'videos_tab_page_state.dart';


class VideosTabPageCubit extends Cubit<VideosTabPageState> {
  VideosTabPageCubit({required this.repo}) : super(VideosTabPageState.loading()) {
    getVideos();
  }

  VideosRepository repo;

  Future<void> getVideos() async {
    emit(VideosTabPageState.loading());
    List<VideoTopic>? videos;
    try {
      videos = await repo.getVideos();
    } catch(e) {
      emit(VideosTabPageState.failed());
    }

    if(videos == null){
      emit(VideosTabPageState.failed());
    } else if (videos.isEmpty) {
      emit(VideosTabPageState.failed());
    } else {
      emit(VideosTabPageState.success(videos));
    }
    return;
  }
}