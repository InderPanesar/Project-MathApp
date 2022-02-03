part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {
  factory HomePageState.loading() = HomePageStateLoading;
  factory HomePageState.empty() = HomePageStateEmpty;
  factory HomePageState.failed() = HomePageStateFailed;
  factory HomePageState.success(UserDetails details) = HomePageStateSuccess;
}

class HomePageStateLoading extends Equatable implements HomePageState {
  @override List<Object> get props => [];
}

class HomePageStateEmpty extends Equatable implements HomePageState {
  @override List<Object> get props => [];
}

class HomePageStateFailed extends Equatable implements HomePageState {
  @override List<Object> get props => [];
}

class HomePageStateSuccess extends Equatable implements HomePageState {
  final UserDetails details;
  HomePageStateSuccess(this.details);
  @override List<Object> get props => [this.details];
}