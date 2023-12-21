import 'package:synapsis_survey_app/data/models/question.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';

class SurveyDetailModelWrapper {
  final SurveyDetailModel? data;

  const SurveyDetailModelWrapper({
    this.data,
  });

  factory SurveyDetailModelWrapper.fromJson(Map<String, dynamic> map) {
    return SurveyDetailModelWrapper(
        data: map['data'] == null
            ? null
            : SurveyDetailModel.fromJson(map['data'] as Map<String, dynamic>));
  }
}

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
      surveyId: map['id'] ?? "",
      surveyName: map['name'] ?? "",
      questions: map['question'] != null
          ? List<QuestionModel>.from(
              map['questions']?.map((x) => QuestionModel.fromJson(x)))
          : [],
    );
  }
}
