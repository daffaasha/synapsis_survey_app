part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class Login extends AuthenticationEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const Login(
      {required this.email, required this.password, required this.rememberMe});
}
