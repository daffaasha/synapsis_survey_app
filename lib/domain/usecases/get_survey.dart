import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class GetSurveyListUseCase {
  final Repository _repository;

  GetSurveyListUseCase(this._repository);

  Future<DataState<List<SurveyEntity>>> call(String? token) async {
    return _repository.getSurveyList();
  }
}
