import 'dart:io';

import 'package:synapsis_survey_app/data/data_sources/remote/survey_api_service.dart';
import 'package:synapsis_survey_app/data/models/survey_detail.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final SurveyApiService _apiService;

  RepositoryImpl(this._apiService);

  @override
  Future<SurveyDetailModel> getSurveyDetail(
      String? token, String? surveyId) async {
    try {
      final httpResponse = await _apiService.getSurveyDetail(
        token: token,
        surveyId: surveyId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data;
      } else {
        throw Exception(httpResponse.response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<SurveyEntity>> getSurveyList(String? token) async {
    try {
      final httpResponse = await _apiService.getSurveyList(
        token: token,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data;
      } else {
        throw Exception(httpResponse.response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final httpResponse = await _apiService.login(
        email: email,
        password: password,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data;
      } else {
        throw Exception(httpResponse.response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
