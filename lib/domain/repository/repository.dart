import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';

abstract class Repository {
  Future<DataState<UserEntity>> login(String email, String password);

  Future<DataState<List<SurveyEntity>>> getSurveyList();

  Future<DataState<SurveyDetailEntity>> getSurveyDetail(String? surveyId);
}
