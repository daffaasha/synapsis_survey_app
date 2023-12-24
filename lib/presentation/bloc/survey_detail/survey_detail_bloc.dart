import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/survey_detail.dart';
import 'package:synapsis_survey_app/domain/usecases/get_survey_detail.dart';

part 'survey_detail_event.dart';
part 'survey_detail_state.dart';

class SurveyDetailBloc extends Bloc<SurveyDetailEvent, SurveyDetailState> {
  final GetSurveyDetailUseCase getSurveyDetailUseCase;

  SurveyDetailBloc(this.getSurveyDetailUseCase) : super(SurveyDetailInitial()) {
    on<GetSurveyDetail>(onGetSurveyDetail);
    on<NextQuestion>(onNextQuestion);
    on<PreviousQuestion>(onPreviousQuestion);
    on<ChooseCheckbox>(onChooseCheckbox);
    on<ChooseRadio>(onChooseRadio);
  }

  void onGetSurveyDetail(
      GetSurveyDetail event, Emitter<SurveyDetailState> emit) async {
    emit(SurveyDetailLoading());

    final response = await getSurveyDetailUseCase(event.surveyId);

    if (response is DataSuccess<SurveyDetailEntity>) {
      if (response.data?.questions?.isEmpty ?? true) {
        emit(const SurveyDetailError("Survey not found"));
        return;
      }
      final checkBox = List<bool>.filled(
          response.data?.questions?.first.options?.length ?? 0, false);
      final answers =
          List<int>.filled(response.data?.questions?.length ?? 0, -1);
      emit(SurveyDetailLoaded(
          surveyDetailEntity: response.data!,
          checkboxState: checkBox,
          answers: answers));
    } else if (response is DataError) {
      emit(SurveyDetailError(response.message!));
    } else {
      emit(const SurveyDetailError("Something went wrong"));
    }
  }

  void onNextQuestion(NextQuestion event, Emitter<SurveyDetailState> emit) {
    final state = this.state as SurveyDetailLoaded;
    final nextAnswer = state.answers[state.index + 1];
    final totalQuestion = state.surveyDetailEntity?.questions?.length ?? 0;
    var checkBox = List<bool>.empty(growable: true);

    if (nextAnswer != -1 && nextAnswer is List<bool>) {
      checkBox = nextAnswer;
    } else {
      checkBox = List<bool>.filled(
          state.surveyDetailEntity?.questions?[state.index + 1].options
                  ?.length ??
              0,
          false);
    }

    if (nextAnswer != -1 && nextAnswer is int) {
      emit(state.copyWith(
          index:
              state.index >= totalQuestion - 1 ? state.index : state.index + 1,
          checkboxState: checkBox,
          radioState: nextAnswer));
    } else {
      emit(state.copyWith(
          index:
              state.index >= totalQuestion - 1 ? state.index : state.index + 1,
          checkboxState: checkBox,
          radioState: -1));
    }
  }

  void onPreviousQuestion(
      PreviousQuestion event, Emitter<SurveyDetailState> emit) {
    final state = this.state as SurveyDetailLoaded;
    final prevAnswer = state.answers[state.index - 1];
    final checkBox = List<bool>.empty(growable: true);

    if (prevAnswer != -1 && prevAnswer is List<bool>) {
      checkBox.addAll(prevAnswer);
    } else {
      checkBox.addAll(List<bool>.filled(
          state.surveyDetailEntity?.questions?[state.index - 1].options
                  ?.length ??
              0,
          false));
    }

    if (prevAnswer != -1 && prevAnswer is int) {
      emit(state.copyWith(
          index: state.index <= 0 ? 0 : state.index - 1,
          checkboxState: checkBox,
          radioState: prevAnswer));
    } else {
      emit(state.copyWith(
          index: state.index <= 0 ? 0 : state.index - 1,
          checkboxState: checkBox,
          radioState: -1));
    }
  }

  void onChooseCheckbox(ChooseCheckbox event, Emitter<SurveyDetailState> emit) {
    final state = this.state as SurveyDetailLoaded;
    var answers = List.from(state.answers);
    var checkboxState = List<bool>.from(state.checkboxState);
    final index = event.index;
    final value = event.value;
    final totalOptions =
        state.surveyDetailEntity?.questions?[state.index].options?.length ?? 0;

    if (checkboxState.length < totalOptions) {
      checkboxState.add(value);
    } else {
      checkboxState[index] = value;
    }

    answers[state.index] = checkboxState;

    emit(state.copyWith(answers: answers, checkboxState: checkboxState));
  }

  void onChooseRadio(ChooseRadio event, Emitter<SurveyDetailState> emit) {
    final state = this.state as SurveyDetailLoaded;
    var answers = List.from(state.answers);
    final index = event.index;

    answers[state.index] = index;

    emit(state.copyWith(answers: answers, radioState: index));
  }
}
