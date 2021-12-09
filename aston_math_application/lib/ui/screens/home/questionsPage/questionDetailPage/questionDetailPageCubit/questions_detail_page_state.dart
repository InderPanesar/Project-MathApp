part of 'questions_detail_page_cubit.dart';

@immutable
abstract class QuestionDetailPageState {
  factory QuestionDetailPageState.loading() = QuestionDetailPageStateLoading;
  factory QuestionDetailPageState.empty() = QuestionDetailPageStateEmpty;
  factory QuestionDetailPageState.failed() = QuestionDetailPageStateFailed;
  factory QuestionDetailPageState.success(List<Question> questions) = QuestionDetailPageStateSuccess;
}

class QuestionDetailPageStateLoading extends Equatable implements QuestionDetailPageState {
  @override List<Object> get props => [];
}

class QuestionDetailPageStateEmpty extends Equatable implements QuestionDetailPageState {
  @override List<Object> get props => [];
}

class QuestionDetailPageStateFailed extends Equatable implements QuestionDetailPageState {
  @override List<Object> get props => [];
}

class QuestionDetailPageStateSuccess extends Equatable implements QuestionDetailPageState {
  final List<Question> questions;
  QuestionDetailPageStateSuccess(this.questions);
  @override List<Object> get props => [this.questions];
}
