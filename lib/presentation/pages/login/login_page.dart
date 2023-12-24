import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/config/theme/dimens.dart';
import 'package:synapsis_survey_app/injection_container.dart';
import 'package:synapsis_survey_app/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_outlined_button.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_primary_button.dart';
import 'package:synapsis_survey_app/presentation/widget/survey_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (loginContext) => LoginBloc()),
        BlocProvider<AuthenticationBloc>(
          create: (authContext) => sl<AuthenticationBloc>(),
        ),
      ],
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          _goToHome(context);
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: mediumPadding1, vertical: largePadding1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildRememberMeCheckBox(),
              _buildLoginButton(),
              _buildFingerPrintButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.popAndPushNamed(context, '/Home', arguments: true);
  }

  _buildTitle() {
    return const Text(
      'Login to Synapsis',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildEmailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SurveyTextField(
          (value) => context.read<LoginBloc>().add(EmailChanged(value)),
          hintText: 'relawan1@relawan.com',
          labelText: 'Email',
          topPadding: largePadding1,
          isPassword: false,
        );
      },
    );
  }

  _buildPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SurveyTextField(
          (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
          hintText: '********',
          labelText: 'Password',
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,
          topPadding: mediumPadding1,
        );
      },
    );
  }

  _buildRememberMeCheckBox() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: smallPadding2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: state.rememberMe,
                  side: const BorderSide(color: softBlue2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  onChanged: (value) {
                    context.read<LoginBloc>().add(RememberMeChanged(value!));
                  },
                ),
              ),
              const SizedBox(width: smallPadding2),
              const Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: gray,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildLoginButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(top: largePadding1),
            child: SurveyPrimaryButton(
              text: 'Log In',
              onClick: () {
                final email = context.read<LoginBloc>().state.email;
                final password = context.read<LoginBloc>().state.password;
                final rememberMe = context.read<LoginBloc>().state.rememberMe;
                context.read<AuthenticationBloc>().add(Login(
                    email: email, password: password, rememberMe: rememberMe));
              },
            ));
      },
    );
  }

  _buildFingerPrintButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
      return Column(
        children: [
          const SizedBox(height: mediumPadding1),
          const Text("Or",
              style: TextStyle(
                color: primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: mediumPadding1),
          SurveyOutlinedButton(
            text: 'Use fingerprint',
            onClick: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("This Feature is not available yet"),
                  backgroundColor: Colors.grey,
                ),
              );
            },
          )
        ],
      );
    }));
  }
}
