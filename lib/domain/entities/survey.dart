import 'package:equatable/equatable.dart';

class SurveyEntity extends Equatable {
  final String? surveyId;
  final String? surveyName;
  final String? createdAt;
  final String? surveyImage;

  const SurveyEntity({
    this.surveyId,
    this.surveyName,
    this.createdAt,
    this.surveyImage,
  });

  @override
  List<Object?> get props => [
        surveyId,
        surveyName,
        createdAt,
        surveyImage,
      ];
}
