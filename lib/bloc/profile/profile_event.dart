part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class SaveProfileData extends ProfileEvent {}

class DeleteProfile extends ProfileEvent {}