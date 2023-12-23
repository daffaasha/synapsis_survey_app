import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/usecases/delete_user.dart';
import 'package:synapsis_survey_app/domain/usecases/get_user.dart';
import 'package:synapsis_survey_app/domain/usecases/login.dart';
import 'package:synapsis_survey_app/domain/usecases/save_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final SaveUserUseCase saveUserUseCase;
  final DeleteUseUseCase deleteUseUseCase;

  AuthenticationBloc(this.loginUseCase, this.deleteUseUseCase,
      this.getUserUseCase, this.saveUserUseCase)
      : super(AuthenticationInitial()) {
    on<Login>(onLogin);
    on<CheckLogin>(onCheckLogin);
    on<Logout>(onLogout);
  }

  void onLogin(Login event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final dataState = await loginUseCase(event.email, event.password);

    if (dataState is DataSuccess) {
      if (event.rememberMe) {
        await saveUserUseCase(UserEntity(
            userId: dataState.data!.userId,
            userName: dataState.data!.userName,
            email: dataState.data!.email,
            phone: dataState.data!.phone));
      }
      emit(AuthenticationAuthenticated(dataState.data!));
    }

    if (dataState is DataError) {
      emit(AuthenticationError(dataState.message!));
    }
  }

  void onCheckLogin(CheckLogin event, Emitter<AuthenticationState> emit) async {
    final user = await getUserUseCase();
    final email = user.email!;
    if (email.isNotEmpty) {
      emit(AuthenticationAuthenticated(user));
      print("User From Hive");
    }

    if (state is AuthenticationAuthenticated) {
      emit(AuthenticationAuthenticated(state.user!));
      print("User From Login");
    } else {
      emit(const AuthenticationError("User not found"));
      print("User Not Login");
    }
  }

  FutureOr<void> onLogout(Logout event, Emitter<AuthenticationState> emit) {
    deleteUseUseCase();
    emit(AuthenticationInitial());
  }
}
