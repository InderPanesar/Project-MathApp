part of 'example_cubit.dart';

@immutable
abstract class ExampleState {
  factory ExampleState.loading() = ExampleStateLoading;
  factory ExampleState.empty() = ExampleStateEmpty;
  factory ExampleState.failed() = ExampleStateFailed;
  factory ExampleState.success(List<ExampleResponse> films) = ExampleStateSuccess;
}

class ExampleStateLoading extends Equatable implements ExampleState {
  @override List<Object> get props => [];
}

class ExampleStateEmpty extends Equatable implements ExampleState {
  @override List<Object> get props => [];
}

class ExampleStateFailed extends Equatable implements ExampleState {
  @override List<Object> get props => [];
}

class ExampleStateSuccess extends Equatable implements ExampleState {
  final List<ExampleResponse> films;
  ExampleStateSuccess(this.films);
  @override List<Object> get props => [this.films];
}