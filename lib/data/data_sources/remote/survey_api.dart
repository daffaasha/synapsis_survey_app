import 'package:dio/dio.dart';
import 'package:synapsis_survey_app/core/constants/constant.dart';

class ApiService {
  final baseUrl = BASE_URL;
  final Dio dio;

  const ApiService(this.dio);

  Future<ApiResponse> login(String email, String password) async {
    final url = "$baseUrl/login";
    final response = await dio.post(
      url,
      data: {
        "nik": email,
        "password": password,
      },
    );

    return ApiResponse(
      statusCode: response.statusCode,
      data: response.data,
      errorMessage: response.data["message"],
    );
  }

  Future<ApiResponse> getSurveyList({int page = 1, int limit = 10}) async {
    final url = "$baseUrl/assessments?page=$page&limit=$limit";
    final response = await dio.get(url);

    return ApiResponse(
      statusCode: response.statusCode,
      data: response.data,
      errorMessage: response.data["message"],
    );
  }

  Future<ApiResponse> getSurveyDetail(String surveyId) async {
    final url = "$baseUrl/assessments/question/$surveyId";
    final response = await dio.get(url);

    return ApiResponse(
      statusCode: response.statusCode,
      data: response.data,
      errorMessage: response.data["message"],
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
