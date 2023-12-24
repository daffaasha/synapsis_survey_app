import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/config/theme/dimens.dart';
import 'package:synapsis_survey_app/domain/entities/question.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_detail/survey_detail_bloc.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_outlined_button.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_primary_button.dart';

class SurveyPage extends StatefulWidget {
  final String surveyId;

  const SurveyPage({this.surveyId = "vngzpruzso", super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late List<bool> selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SurveyDetailBloc>(
      create: (context) => sl()..add(GetSurveyDetail(widget.surveyId)),
      child: BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
        builder: (context, state) {
          if (state is SurveyDetailLoaded) {
            return Scaffold(
              body: _buildBody(),
              bottomSheet: _buildFooter(),
            );
          } else if (state is SurveyDetailLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("No Data To Show"),
              ),
            );
          }
        },
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: mediumPadding1, vertical: smallPadding2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SurveyOutlinedButton(
            height: 40,
            width: 150,
            onClick: null,
            text: "Timer",
          ),
          SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: smallPadding3, vertical: smallPadding1),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgIcon(
                        "assets/icons/ic_doc.svg",
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
                        builder: (context, state) {
                      final totalQuestions =
                          state.surveyDetailEntity?.questions?.length ?? 0;
                      return Text(
                        "${state.index + 1}/$totalQuestions",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _questionBody(),
          // _buildFooter(),
        ],
      ),
    );
  }

  _questionBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: mediumPadding1,
              left: mediumPadding1,
              top: smallPadding2,
              bottom: mediumPadding1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
                builder: (context, state) {
                  return Text(
                    state.surveyDetailEntity?.surveyName ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  );
                },
              ),
              const SizedBox(
                height: mediumPadding2,
              ),
              BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
                builder: (context, state) {
                  return Text(
                    state.surveyDetailEntity?.questions?[state.index]
                            .questionName ??
                        "",
                    style: const TextStyle(color: gray2, fontSize: 18),
                  );
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: softBlue3,
          thickness: smallPadding3,
        ),
        const Padding(
          padding: EdgeInsets.only(
              right: mediumPadding1,
              left: mediumPadding1,
              top: mediumPadding2,
              bottom: smallPadding2),
          child: Text("Answer", style: TextStyle(fontSize: 18)),
        ),
        const Divider(
          color: softGray,
          thickness: 1,
        ),
        BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
          builder: (context, detailState) {
            if (detailState is SurveyDetailLoaded) {
              final totalOptions = detailState.surveyDetailEntity
                      ?.questions?[detailState.index].options?.length ??
                  0;
              final type = detailState
                      .surveyDetailEntity?.questions?[detailState.index].type ??
                  "";
              final listQuestion = detailState.surveyDetailEntity
                      ?.questions?[detailState.index].options ??
                  [];
              final checkBoxState = detailState.checkboxState;
              final radioState = detailState.radioState;

              return _optionBuilder(
                  totalOptions, type, listQuestion, checkBoxState, radioState);
            } else {
              return const Center();
            }
          },
        ),
      ],
    );
  }

  _optionBuilder(int totalOptions, String type, List<OptionEntity> listQuestion,
      List<bool?>? checkBoxState, int radioState) {
    selectedValue = List.filled(listQuestion.length, false);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: totalOptions,
      itemBuilder: (context, index) {
        if (type == "checkbox") {
          return CheckboxListTile(
              value: checkBoxState?.elementAtOrNull(index) ?? false,
              title: Text(
                listQuestion[index].optionName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: gray,
                ),
              ),
              side: const BorderSide(color: softBlue2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                context
                    .read<SurveyDetailBloc>()
                    .add(ChooseCheckbox(index, value!));
              });
        } else if (type == "multiple_choice") {
          return RadioListTile(
              groupValue: radioState,
              value: index,
              title: Text(
                listQuestion[index].optionName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: gray,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                context.read<SurveyDetailBloc>().add(ChooseRadio(index));
              });
        } else {
          return const Center(child: Text("Unknown Format Type"));
        }
      },
    );
  }

  _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: mediumPadding1, vertical: smallPadding3),
      child: Row(
        children: [
          BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
            builder: (context, state) {
              return Expanded(
                child: SurveyOutlinedButton(
                  height: 40,
                  onClick: () {
                    if (state.index > 0) {
                      context
                          .read<SurveyDetailBloc>()
                          .add(const PreviousQuestion());
                    }
                  },
                  text: "Previous",
                ),
              );
            },
          ),
          const SizedBox(
            width: mediumPadding1,
          ),
          BlocBuilder<SurveyDetailBloc, SurveyDetailState>(
            builder: (context, state) {
              final totalQuestions =
                  state.surveyDetailEntity?.questions?.length ?? 0;
              return Expanded(
                child: SurveyPrimaryButton(
                  height: 40,
                  onClick: () {
                    if (state.index < totalQuestions - 1) {
                      context
                          .read<SurveyDetailBloc>()
                          .add(const NextQuestion());
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  text: state.index < totalQuestions - 1 ? "Next" : "Finish",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
