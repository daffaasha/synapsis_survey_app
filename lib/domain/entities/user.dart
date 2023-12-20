import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? userName;
  final String? email;
  final String? phone;

  const UserEntity({
    this.userId,
    this.userName,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [userName, userName, email, phone];
}
