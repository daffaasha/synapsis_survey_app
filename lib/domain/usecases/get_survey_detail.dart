import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class GetSurveyDetailUseCase {
  final Repository _repository;

  GetSurveyDetailUseCase(this._repository);

  Future<DataState<SurveyDetailEntity>> call(String? surveyId) {
    return _repository.getSurveyDetail(surveyId);
  }
}
