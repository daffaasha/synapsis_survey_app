import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetSurveyListUseCase surveyUseCase;

  SurveyBloc(this.surveyUseCase) : super(SurveyLoading()) {
    on<SurveyEvent>(onGetSurvey);
  }

  void onGetSurvey(SurveyEvent event, Emitter<SurveyState> emit) async {
    final result = await surveyUseCase.call("");

    if (result is DataSuccess && result.data != null) {
      emit(SurveySuccess(surveyList: result.data!));
    } else if (result is DataError) {
      emit(SurveyFailure(surveyList: result.message));
    }
  }
}
