import 'package:synapsis_survey_app/domain/repository/repository.dart';

class DeleteUseUseCase {
  final Repository _repository;

  DeleteUseUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteUser();
  }
}
