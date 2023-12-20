import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:synapsis_survey_app/core/constants/constant.dart';
import 'package:synapsis_survey_app/data/models/survey.dart';
import 'package:synapsis_survey_app/data/models/survey_detail.dart';
import 'package:synapsis_survey_app/data/models/user.dart';
part 'survey_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class SurveyApiService {
  factory SurveyApiService(Dio dio) = _SurveyApiService;

  @POST('login')
  Future<HttpResponse<UserModel>> login({
    @Field("email") String? email,
    @Field("password") String? password,
  });

  @GET('assessments')
  Future<HttpResponse<List<SurveyModel>>> getSurveyList({
    @Header("Authorization") String? token,
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  @GET('assessments/{surveyId}')
  Future<HttpResponse<SurveyDetailModel>> getSurveyDetail({
    @Header("Authorization") String? token,
    @Path("surveyId") String? surveyId,
  });
}
