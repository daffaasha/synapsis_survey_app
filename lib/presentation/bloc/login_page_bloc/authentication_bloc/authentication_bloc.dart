import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/usecases/login.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;

  AuthenticationBloc(this.loginUseCase) : super(AuthenticationInitial()) {
    on<Login>(onLogin);
  }

  void onLogin(Login event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final dataState = await loginUseCase(event.email, event.password);

    if (dataState is DataSuccess) {
      emit(AuthenticationAuthenticated(dataState.data!));
      print(dataState.data?.email ?? "Kucing");
    }

    if (dataState is DataError) {
      emit(AuthenticationError(dataState.message!));
      print(dataState.message ?? "Error");
    }
  }
}
