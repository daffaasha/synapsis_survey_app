import 'package:hive/hive.dart';
import 'package:synapsis_survey_app/core/constants/constant.dart';
import 'package:synapsis_survey_app/data/models/user.dart';

class UserPreference {
  final Box box;

  UserPreference(this.box);

  Future<void> saveUser(
      String userId, String userName, String email, String phone) async {
    await box.put(USER_ID, userId);
    await box.put(USER_NAME, userName);
    await box.put(USER_EMAIL, email);
    await box.put(USER_PHONE, phone);
  }

  Future<void> deleteUser() async {
    await box.delete(USER_ID);
    await box.delete(USER_NAME);
    await box.delete(USER_EMAIL);
    await box.delete(USER_PHONE);
  }

  Future<UserModel> getUser() async {
    final userId = box.get(USER_ID);
    final userName = box.get(USER_NAME);
    final email = box.get(USER_EMAIL);
    final phone = box.get(USER_PHONE);

    return UserModel(
      userId: userId ?? "",
      userName: userName ?? "",
      email: email ?? "",
      phone: phone ?? "",
    );
  }
}
