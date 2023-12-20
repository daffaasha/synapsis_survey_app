import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';

abstract class Repository {
  Future<UserEntity> login(String email, String password);

  Future<List<SurveyEntity>> getSurveyList(String? token);

  Future<SurveyDetailEntity> getSurveyDetail(String? token, String? surveyId);
}
