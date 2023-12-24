import 'package:flutter/material.dart';
import 'package:synapsis_survey_app/presentation/pages/home/home_page.dart';
import 'package:synapsis_survey_app/presentation/pages/login/login_page.dart';
import 'package:synapsis_survey_app/presentation/pages/survey/survey_page.dart';

class AppRoute {
  static Route onGeneralRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/Login':
        return _materialRoute(const LoginPage());

      case '/Home':
        return _materialRoute(HomePage(isLoggedIn: settings.arguments as bool));

      case '/Detail':
        return _materialRoute(SurveyPage(
          surveyId: settings.arguments as String,
        ));

      default:
        return _materialRoute(const LoginPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
