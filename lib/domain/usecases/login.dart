import 'package:synapsis_survey_app/core/resource/data_state.dart';
import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class LoginUseCase {
  final Repository _repository;

  LoginUseCase(this._repository);

  Future<DataState<UserEntity>> call(String email, String password) async {
    return _repository.login(email, password);
  }
}
