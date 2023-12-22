import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/config/route/routes.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/authentication_bloc/authentication_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survey_app/presentation/pages/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (create) => sl<AuthenticationBloc>(),
        ),
      ],
      child: const MaterialApp(
        onGenerateRoute: AppRoute.onGeneralRoutes,
        home: LoginPage(),
      ),
    );
  }
}
