part of 'survey_detail_bloc.dart';

sealed class SurveyDetailEvent {
  const SurveyDetailEvent();
}

class GetSurveyDetail extends SurveyDetailEvent {
  final String surveyId;

  const GetSurveyDetail(this.surveyId);
}

class NextQuestion extends SurveyDetailEvent {
  const NextQuestion();
}

class PreviousQuestion extends SurveyDetailEvent {
  const PreviousQuestion();
}

class ChooseCheckbox extends SurveyDetailEvent {
  final int index;
  final bool value;

  const ChooseCheckbox(this.index, this.value);
}

class ChooseRadio extends SurveyDetailEvent {
  final int index;

  const ChooseRadio(this.index);
}
