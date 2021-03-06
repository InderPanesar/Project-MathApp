part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  factory LoginState.loading() = LoginStateLoading;
  factory LoginState.empty() = LoginStateEmpty;
  factory LoginState.failed(String errorMessage) = LoginStateFailed;
  factory LoginState.success() = LoginStateSuccess;
}

class LoginStateLoading extends Equatable implements LoginState {
  @override List<Object> get props => [];
}

class LoginStateEmpty extends Equatable implements LoginState {
  @override List<Object> get props => [];
}

class LoginStateFailed extends Equatable implements LoginState {
  final String errorMessage;
  LoginStateFailed(this.errorMessage);
  @override List<Object> get props => [];
}

class LoginStateSuccess extends Equatable implements LoginState {
  @override List<Object> get props => [];
}