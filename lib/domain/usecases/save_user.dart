import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class SaveUserUseCase {
  final Repository _repository;

  SaveUserUseCase(this._repository);

  Future<void> call(UserEntity user) async {
    await _repository.saveUser(
        user.userId!, user.userName!, user.email!, user.phone!);
  }
}
