part of 'login_bloc.dart';

class LoginState {
  final UserEntity? user;
  final String? error;
  final String email;
  final String password;
  final bool rememberMe;
  final bool isPasswordVisible;

  const LoginState(
      {this.user,
      this.error,
      this.email = "",
      this.password = "",
      this.rememberMe = false,
      this.isPasswordVisible = false});

  LoginState copyWith({
    UserEntity? user,
    String? error,
    String? email,
    String? password,
    bool? rememberMe,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      user: user ?? this.user,
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial();
}
