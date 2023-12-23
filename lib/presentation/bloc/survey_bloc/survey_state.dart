part of 'survey_bloc.dart';

sealed class SurveyState {
  final List<SurveyEntity?> surveyList;
  final String? message;

  const SurveyState({this.surveyList = const <SurveyEntity>[], this.message});
}

final class SurveyLoading extends SurveyState {}

final class SurveySuccess extends SurveyState {
  const SurveySuccess({required List<SurveyEntity?> surveyList})
      : super(surveyList: surveyList);
}

final class SurveyFailure extends SurveyState {
  const SurveyFailure({required String? surveyList})
      : super(message: surveyList);
}
