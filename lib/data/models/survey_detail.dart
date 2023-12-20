import 'package:synapsis_survey_app/data/models/question.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';

class SurveyDetailModel extends SurveyDetailEntity {
  const SurveyDetailModel({
    String? surveyId,
    String? surveyName,
    List<QuestionModel>? questions,
  }) : super(
          surveyId: surveyId,
          surveyName: surveyName,
          questions: questions,
        );

  factory SurveyDetailModel.fromJson(Map<String, dynamic> map) {
    return SurveyDetailModel(
      surveyId: map['survey_id'] ?? "",
      surveyName: map['survey_name'] ?? "",
      questions: map['questions'] != null
          ? List<QuestionModel>.from(
              map['questions']?.map((x) => QuestionModel.fromJson(x)))
          : [],
    );
  }
}
