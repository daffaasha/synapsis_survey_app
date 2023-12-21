import 'dart:convert';

import 'package:synapsis_survey_app/core/constants/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = BASE_URL;

  const ApiService();

  Future<ApiResponse> login(String email, String password) async {
    final uri = Uri.parse("$baseUrl/login");
    final response = await http.post(
      uri,
      body: {
        "nik": email,
        "password": password,
      },
    );
    final data = jsonDecode(response.body);

    return ApiResponse(
      statusCode: response.statusCode,
      data: data,
      errorMessage: data["message"],
    );
  }

  Future<ApiResponse> getSurveyList({int page = 1, int limit = 10}) async {
    final uri = Uri.parse("$baseUrl/assessments?page=$page&limit=$limit");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    return ApiResponse(
      statusCode: response.statusCode,
      data: data,
      errorMessage: data["message"],
    );
  }

  Future<ApiResponse> getSurveyDetail(String surveyId) async {
    final uri = Uri.parse("$baseUrl/assessments/$surveyId");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    return ApiResponse(
      statusCode: response.statusCode,
      data: data,
      errorMessage: data["message"],
    );
  }
}

class ApiResponse {
  final int? statusCode;
  final dynamic data;
  final String? errorMessage;

  ApiResponse({
    this.statusCode,
    this.data,
    this.errorMessage,
  });
}
