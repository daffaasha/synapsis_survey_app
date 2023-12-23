import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/dio_config.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/survey_api.dart';
import 'package:synapsis_survey_app/data/repository/repository.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey_detail.dart';
import 'package:synapsis_survey_app/domain/usecases/login.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/authentication_bloc/authentication_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_bloc/survey_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  final dioConfig = DioConfig(dio);
  await dioConfig.configDio();

  //Dio
  sl.registerLazySingleton(() => dioConfig.dio);

  sl.registerSingleton(ApiService(sl()));

  sl.registerSingleton<Repository>(RepositoryImpl(sl()));

  //Usecases
  sl.registerSingleton(GetSurveyListUseCase(sl()));

  sl.registerSingleton(GetSurveyDetailUseCase(sl()));

  sl.registerSingleton(LoginUseCase(sl()));

  //Bloc
  sl.registerFactory(() => AuthenticationBloc(sl()));

  sl.registerFactory(() => SurveyBloc(sl()));
}
