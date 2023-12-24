import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:synapsis_survey_app/data/data_sources/local/user_pref.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/dio_config.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/survey_api.dart';
import 'package:synapsis_survey_app/data/repository/repository.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';
import 'package:synapsis_survey_app/domain/usecases/delete_user.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey_detail.dart';
import 'package:synapsis_survey_app/domain/usecases/get_user.dart';
import 'package:synapsis_survey_app/domain/usecases/login.dart';
import 'package:synapsis_survey_app/domain/usecases/save_user.dart';
import 'package:synapsis_survey_app/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_bloc/survey_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_detail/survey_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  final dioConfig = DioConfig(dio);
  await dioConfig.configDio();

  //Dio
  sl.registerLazySingleton(() => dioConfig.dio);

  final box = Hive.box('myUserPref');

  sl.registerLazySingleton(() => box);

  sl.registerLazySingleton(() => UserPreference(sl()));

  sl.registerSingleton(ApiService(sl()));

  sl.registerSingleton<Repository>(RepositoryImpl(sl(), sl()));

  //Usecases
  sl.registerSingleton(GetSurveyListUseCase(sl()));

  sl.registerSingleton(GetSurveyDetailUseCase(sl()));

  sl.registerSingleton(LoginUseCase(sl()));

  sl.registerSingleton(SaveUserUseCase(sl()));

  sl.registerSingleton(DeleteUseUseCase(sl()));

  sl.registerSingleton(GetUserUseCase(sl()));

  //Bloc
  sl.registerFactory(() => AuthenticationBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory(() => SurveyBloc(sl()));

  sl.registerFactory(() => SurveyDetailBloc(sl()));
}
