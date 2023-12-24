import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:synapsis_survey_app/config/route/routes.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/pages/home/home_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('myUserPref');
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoute.onGeneralRoutes,
      home: HomePage(),
    );
  }
}
