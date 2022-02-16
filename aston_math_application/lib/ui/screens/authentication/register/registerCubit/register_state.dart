part of 'register_cubit.dart';

@immutable
abstract class RegisterState {
  factory RegisterState.loading() = RegisterStateLoading;
  factory RegisterState.empty() = RegisterStateEmpty;
  factory RegisterState.failed(String errorMessage) = RegisterStateFailed;
  factory RegisterState.success() = RegisterStateSuccess;
}

class RegisterStateLoading extends Equatable implements RegisterState {
  @override List<Object> get props => [];
}

class RegisterStateEmpty extends Equatable implements RegisterState {
  @override List<Object> get props => [];
}

class RegisterStateFailed extends Equatable implements RegisterState {
  final String errorMessage;
  RegisterStateFailed(this.errorMessage);
  @override List<Object> get props => [];
}

class RegisterStateSuccess extends Equatable implements RegisterState {
  @override List<Object> get props => [];
}