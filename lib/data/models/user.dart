import 'package:synapsis_survey_app/domain/entities/user.dart';

class UserModelWrapper {
  final UserModel? data;

  const UserModelWrapper({
    this.data,
  });

  factory UserModelWrapper.fromJson(Map<String, dynamic> map) {
    return UserModelWrapper(
        data: map['data'] == null
            ? null
            : UserModel.fromJson(map['data'] as Map<String, dynamic>));
  }
}

class UserModel extends UserEntity {
  const UserModel({
    String? userId,
    String? userName,
    String? email,
    String? phone,
  }) : super(userId: userId, userName: userName, email: email, phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] ?? "",
      userName: map['name'] ?? "",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
    );
  }
}
