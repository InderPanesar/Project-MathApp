part of 'videos_tab_page_cubit.dart';

@immutable
abstract class VideosTabPageState {
  factory VideosTabPageState.loading() = VideosTabPageStateLoading;
  factory VideosTabPageState.empty() = VideosTabPageStateEmpty;
  factory VideosTabPageState.failed() = VideosTabPageStateFailed;
  factory VideosTabPageState.success(List<VideoTopic> videos) = VideosTabPageStateSuccess;
}

class VideosTabPageStateLoading extends Equatable implements VideosTabPageState {
  @override List<Object> get props => [];
}

class VideosTabPageStateEmpty extends Equatable implements VideosTabPageState {
  @override List<Object> get props => [];
}

class VideosTabPageStateFailed extends Equatable implements VideosTabPageState {
  @override List<Object> get props => [];
}

class VideosTabPageStateSuccess extends Equatable implements VideosTabPageState {
  final List<VideoTopic> videos;
  VideosTabPageStateSuccess(this.videos);
  @override List<Object> get props => [this.videos];
}