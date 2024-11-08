part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated({required this.user});
}

class UserUnauthenticated extends UserState {}

class UserLoading extends UserState {}