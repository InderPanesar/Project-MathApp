part of 'change_details_cubit.dart';

@immutable
abstract class UserDetailsState {
  factory UserDetailsState.loading() = UserDetailsStateLoading;
  factory UserDetailsState.empty() = UserDetailsStateEmpty;
  factory UserDetailsState.failed(String errorMessage) = UserDetailsStateFailed;
  factory UserDetailsState.success() = UserDetailsStateSuccess;
}

class UserDetailsStateLoading extends Equatable implements UserDetailsState {
  @override List<Object> get props => [];
}

class UserDetailsStateEmpty extends Equatable implements UserDetailsState {
  @override List<Object> get props => [];
}

class UserDetailsStateFailed extends Equatable implements UserDetailsState {
  final String errorMessage;
  UserDetailsStateFailed(this.errorMessage);
  @override List<Object> get props => [];
}

class UserDetailsStateSuccess extends Equatable implements UserDetailsState {
  @override List<Object> get props => [];
}