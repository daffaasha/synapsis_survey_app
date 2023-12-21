import 'dart:io';
import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/survey_api.dart';
import 'package:synapsis_survey_app/data/models/survey.dart';
import 'package:synapsis_survey_app/data/models/survey_detail.dart';
import 'package:synapsis_survey_app/data/models/user.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final ApiService _api;

  RepositoryImpl(this._api);

  @override
  Future<DataState<SurveyDetailModel>> getSurveyDetail(String? surveyId) async {
    try {
      final response = await _api.getSurveyDetail(surveyId!);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            SurveyDetailModelWrapper.fromJson(response.data).data!);
      } else {
        return DataError(
          "Error ${response.statusCode}: ${response.errorMessage}",
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<List<SurveyEntity>>> getSurveyList() async {
    try {
      final response = await _api.getSurveyList();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(SurveyModelWrapper.fromJson(response.data).data!);
      } else {
        return DataError(
          "Error ${response.statusCode}: ${response.errorMessage}",
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<UserEntity>> login(String email, String password) async {
    try {
      final response = await _api.login(email, password);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(UserModelWrapper.fromJson(response.data).data!);
      } else {
        return DataError(
          "Error ${response.statusCode}: ${response.errorMessage}",
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
