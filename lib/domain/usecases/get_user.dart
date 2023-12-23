import 'package:synapsis_survey_app/domain/entities/user.dart';
import 'package:synapsis_survey_app/domain/repository/repository.dart';

class GetUserUseCase {
  final Repository _userRepository;

  GetUserUseCase(this._userRepository);

  Future<UserEntity> call() async {
    return await _userRepository.getUser();
  }
}
