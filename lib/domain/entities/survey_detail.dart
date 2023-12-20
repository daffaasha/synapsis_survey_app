import 'package:equatable/equatable.dart';
import 'package:synapsis_survey_app/domain/entities/question.dart';

class SurveyDetailEntity extends Equatable {
  final String? surveyId;
  final String? surveyName;
  final List<QuestionEntity>? questions;

  const SurveyDetailEntity({
    this.surveyId,
    this.surveyName,
    this.questions,
  });

  @override
  List<Object?> get props => [surveyId, surveyName, questions];
}
