import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/config/theme/dimens.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/authentication_bloc/authentication_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/survey_bloc/survey_bloc.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_card.dart';

class HomePage extends StatelessWidget {
  final bool isLoggedIn;

  const HomePage({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SurveyBloc>(
            create: (context) => sl<SurveyBloc>(),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (create) =>
                sl<AuthenticationBloc>()..add(const CheckLogin()),
          ),
        ],
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (blocContext, state) {
              if (state is AuthenticationAuthenticated || isLoggedIn) {
                BlocProvider.of<SurveyBloc>(blocContext)
                    .add(const GetSurveyListEvent());
              } else if (state is AuthenticationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.popAndPushNamed(context, '/Login');
              }
            },
            child: _buildBody(),
          ),
        ));
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
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(const Logout());
                Navigator.popAndPushNamed(context, '/Login');
              },
              icon: const Icon(Icons.logout, color: Colors.black),
            );
          }),
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
