part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileData extends ProfileState {
  final Profile profile;

  ProfileData({required this.profile});
}

class ProfileEmpty extends ProfileState {}

class ProfileLoading extends ProfileState {}