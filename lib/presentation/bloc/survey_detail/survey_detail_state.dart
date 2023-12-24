part of 'survey_detail_bloc.dart';

sealed class SurveyDetailState {
  final int index;
  final SurveyDetailEntity? surveyDetailEntity;
  final List<dynamic> answers;
  final List<bool> checkboxState;
  final int radioState;

  const SurveyDetailState(
      {this.surveyDetailEntity = const SurveyDetailEntity(),
      this.index = 0,
      this.answers = const [],
      this.checkboxState = const [],
      this.radioState = -1});
}

final class SurveyDetailInitial extends SurveyDetailState {}

final class SurveyDetailLoading extends SurveyDetailState {}

final class SurveyDetailLoaded extends SurveyDetailState {
  const SurveyDetailLoaded({
    SurveyDetailEntity? surveyDetailEntity = const SurveyDetailEntity(),
    int index = 0,
    List<dynamic> answers = const [],
    List<bool> checkboxState = const [],
    int radioState = -1,
  }) : super(
            surveyDetailEntity: surveyDetailEntity,
            index: index,
            answers: answers,
            checkboxState: checkboxState,
            radioState: radioState);

  SurveyDetailLoaded copyWith({
    SurveyDetailEntity? surveyDetailEntity,
    int? index,
    List<dynamic>? answers,
    List<bool>? checkboxState,
    int? radioState,
  }) {
    return SurveyDetailLoaded(
        surveyDetailEntity: surveyDetailEntity ?? this.surveyDetailEntity!,
        index: index ?? this.index,
        answers: answers ?? this.answers,
        checkboxState: checkboxState ?? this.checkboxState,
        radioState: radioState ?? this.radioState);
  }
}

final class SurveyDetailError extends SurveyDetailState {
  final String errorMessage;

  const SurveyDetailError(this.errorMessage);
}

class AnsweredQuestion {
  final int index;
  final bool isAnswered;
  final List<int>? checkboxAnswer;
  final int? radioAnswer;

  const AnsweredQuestion(
      {this.index = 0,
      this.isAnswered = false,
      this.checkboxAnswer = const [],
      this.radioAnswer = 0});

  AnsweredQuestion copyWith({
    int? index,
    bool? isAnswered,
    List<int>? checkboxAnswer,
    int? radioAnswer,
  }) {
    return AnsweredQuestion(
        index: index ?? this.index,
        isAnswered: isAnswered ?? this.isAnswered,
        checkboxAnswer: checkboxAnswer ?? this.checkboxAnswer,
        radioAnswer: radioAnswer ?? this.radioAnswer);
  }
}
