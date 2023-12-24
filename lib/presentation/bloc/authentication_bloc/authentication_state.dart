part of 'authentication_bloc.dart';

sealed class AuthenticationState {
  final UserEntity? user;
  final String? error;

  const AuthenticationState({this.user, this.error});
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(UserEntity user) : super(user: user);
}

final class AuthenticationError extends AuthenticationState {
  const AuthenticationError(String error) : super(error: error);
}
