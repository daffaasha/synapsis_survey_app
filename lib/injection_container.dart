import 'package:get_it/get_it.dart';
import 'package:synapsis_survey_app/data/data_sources/remote/survey_api.dart';
import 'package:synapsis_survey_app/data/repository/repository.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey_detail.dart';
import 'package:synapsis_survey_app/domain/usecases/login.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/authentication_bloc/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton(const ApiService());

  sl.registerSingleton<Repository>(RepositoryImpl(sl()));

  //Usecases
  sl.registerSingleton(GetSurveyListUseCase(sl()));

  sl.registerSingleton(GetSurveyDetailUseCase(sl()));

  sl.registerSingleton(LoginUseCase(sl()));

  //Bloc
  sl.registerFactory(() => AuthenticationBloc(sl()));
}
