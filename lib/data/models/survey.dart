import 'package:synapsis_survey_app/domain/entities/survey.dart';

class SurveyModelWrapper {
  final List<SurveyModel>? data;

  const SurveyModelWrapper({
    this.data,
  });

  factory SurveyModelWrapper.fromJson(Map<String, dynamic> map) {
    return SurveyModelWrapper(
        data: map['data'] == null
            ? null
            : List<SurveyModel>.from(
                map['data']?.map((x) => SurveyModel.fromJson(x))));
  }
}

class SurveyModel extends SurveyEntity {
  const SurveyModel({
    String? surveyId,
    String? surveyName,
    String? createdAt,
    String? surveyImage,
  }) : super(
          surveyId: surveyId,
          surveyName: surveyName,
          createdAt: createdAt,
          surveyImage: surveyImage,
        );

  factory SurveyModel.fromJson(Map<String, dynamic> map) {
    return SurveyModel(
      surveyId: map['survey_id'] ?? "",
      surveyName: map['survey_name'] ?? "",
      createdAt: map['created_at'] ?? "",
      surveyImage: map['survey_image'] ?? "",
    );
  }
}
