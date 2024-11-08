part of 'user_bloc.dart';

abstract class UserEvent {}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({
    required this.email,
    required this.password,
  });  
}

class SaveUserData extends UserEvent {
  final int id;
  final String token;
  final String username;
  final String email;

  SaveUserData({
    required this.id,
    required this.token,
    required this.username,
    required this.email,
  });
}

class LogoutUser extends UserEvent {}