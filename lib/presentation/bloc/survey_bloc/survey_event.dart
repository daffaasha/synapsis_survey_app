part of 'survey_bloc.dart';

sealed class SurveyEvent {
  const SurveyEvent();
}

class GetSurveyListEvent extends SurveyEvent {
  const GetSurveyListEvent();
}
