import 'package:flutter/material.dart';
import 'package:synapsis_survey_app/presentation/pages/home/home_page.dart';
import 'package:synapsis_survey_app/presentation/pages/login/login_page.dart';

class AppRoute {
  static Route onGeneralRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const LoginPage());

      case '/Home':
        return _materialRoute(const HomePage());

      default:
        return _materialRoute(const LoginPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}