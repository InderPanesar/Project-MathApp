part of 'questions_tab_page_cubit.dart';

@immutable
abstract class QuestionTabPageState {
  factory QuestionTabPageState.loading() = QuestionTabPageStateLoading;
  factory QuestionTabPageState.empty() = QuestionTabPageStateEmpty;
  factory QuestionTabPageState.failed() = QuestionTabPageStateFailed;
  factory QuestionTabPageState.success(List<QuestionTopic> questions) = QuestionTabPageStateSuccess;
}

class QuestionTabPageStateLoading extends Equatable implements QuestionTabPageState {
  @override List<Object> get props => [];
}

class QuestionTabPageStateEmpty extends Equatable implements QuestionTabPageState {
  @override List<Object> get props => [];
}

class QuestionTabPageStateFailed extends Equatable implements QuestionTabPageState {
  @override List<Object> get props => [];
}

class QuestionTabPageStateSuccess extends Equatable implements QuestionTabPageState {
  final List<QuestionTopic> questions;
  QuestionTabPageStateSuccess(this.questions);
  @override List<Object> get props => [this.questions];
}

