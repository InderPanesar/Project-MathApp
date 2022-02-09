import 'package:aston_math_application/engine/model/video/VideoTopic.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'videos_tab_page_state.dart';


class VideosTabPageCubit extends Cubit<VideosTabPageState> {
  VideosTabPageCubit({required this.repo}) : super(VideosTabPageState.loading()) {
    getQuestions();
  }

  VideosRepository repo;

  Future<void> getQuestions() async {
    emit(VideosTabPageState.loading());
    List<VideoTopic>? videos = await repo.getVideos();
    if(videos == null){
      emit(VideosTabPageState.failed());
    } else if (videos.isEmpty) {
      emit(VideosTabPageState.empty());
    } else {
      emit(VideosTabPageState.success(videos));
    }
    return;
  }
}