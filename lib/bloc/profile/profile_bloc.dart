import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_2/models/profile_model.dart';
import 'package:test_2/repositories/user_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({
    required this.userRepository,
  }) : super(ProfileInitial()) {
    on<SaveProfileData>(_onSaveProfileData);
    on<DeleteProfile>(_onDeleteProfile);
    assert(userRepository != null);
  }

  void _onSaveProfileData(SaveProfileData event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

     try {
        final result = await userRepository.userProfile();
        print(result);

        result.fold(
          (error) => print('Error: $error'),
          (profileData) {
            print("bloc profile asdasdadads");
            print(profileData.id);
            emit(ProfileData(
              profile: Profile(
                id: profileData.id,
                username: profileData.username,
                email: profileData.email
              )
            ));
          }
        );

      } catch (error) {
        print(error.toString());
      }
  }

  void _onDeleteProfile(DeleteProfile event, Emitter<ProfileState> emit) {
    emit(ProfileEmpty());
  }
}