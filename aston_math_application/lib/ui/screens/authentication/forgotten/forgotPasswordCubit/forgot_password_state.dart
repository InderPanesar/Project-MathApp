part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgottenPasswordState {
  factory ForgottenPasswordState.loading() = ForgottenPasswordStateLoading;
  factory ForgottenPasswordState.empty() = ForgottenPasswordStateEmpty;
  factory ForgottenPasswordState.failed(String errorMessage) = ForgottenPasswordStateFailed;
  factory ForgottenPasswordState.success() = ForgottenPasswordStateSuccess;
}

class ForgottenPasswordStateLoading extends Equatable implements ForgottenPasswordState {
  @override List<Object> get props => [];
}

class ForgottenPasswordStateEmpty extends Equatable implements ForgottenPasswordState {
  @override List<Object> get props => [];
}

class ForgottenPasswordStateFailed extends Equatable implements ForgottenPasswordState {
  final String errorMessage;
  ForgottenPasswordStateFailed(this.errorMessage);
  @override List<Object> get props => [];
}

class ForgottenPasswordStateSuccess extends Equatable implements ForgottenPasswordState {
  @override List<Object> get props => [];
}