import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/config/theme/dimens.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_bloc/survey_bloc.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SurveyBloc>()..add(const GetSurveyListEvent()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Padding(
        padding: EdgeInsets.only(left: smallPadding2),
        child: Text(
          "Halaman Survei",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: smallPadding2),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        )
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
      if (state is SurveyLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SurveySuccess) {
        return _buildListSurvey(state);
      } else if (state is SurveyFailure) {
        return Center(
          child: Text(state.message!),
        );
      } else {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
    });
  }

  _buildListSurvey(state) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: state.surveyList.length,
        itemBuilder: (context, index) {
          final SurveyEntity survey = state.surveyList[index]!;
          return SurveyCard(
            survey: survey,
            onClick: (value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value), backgroundColor: green),
              )
            },
          );
        },
      ),
    );
  }
}
