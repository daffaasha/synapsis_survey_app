part of 'login_bloc.dart';

sealed class LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isPasswordVisible;

  const LoginEvent(
      {this.email = "",
      this.password = "",
      this.rememberMe = false,
      this.isPasswordVisible = false});
}

class EmailChanged extends LoginEvent {
  const EmailChanged(String email) : super(email: email);
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged(String password) : super(password: password);
}

class RememberMeChanged extends LoginEvent {
  const RememberMeChanged(bool rememberMe) : super(rememberMe: rememberMe);
}

class PasswordVisibilityChanged extends LoginEvent {
  const PasswordVisibilityChanged(bool isPasswordVisible)
      : super(isPasswordVisible: isPasswordVisible);
}
