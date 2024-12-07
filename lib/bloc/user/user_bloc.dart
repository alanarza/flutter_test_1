import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_2/models/user_model.dart';
import 'package:test_2/repositories/user_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  
  UserBloc({
    required this.userRepository,
  }) : super(UserInitial()) {
    on<LoginUser>(_onLogin);
    on<LogoutUser>(_onLogout);
    assert(userRepository != null);
  }

  /*
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserInitial) {
      final bool hasToken = await userRepository.hasToken();

      if(hasToken) {
        emit(state)
      } else {

      }
    }
  }
  */

  void _onLogin(LoginUser event, Emitter<UserState> emit) async {
    
    emit(UserLoading());

    print("Entre al _onLogin");
    print(event.email);
    print(event.password);

    if (event.email != '' && event.password != '') {
      try {
        final result = await userRepository.login(
          event.email, 
          event.password
        );

        result.fold(
          (error) => print('Error: $error'),
          (userData) {
            userRepository.persistToken(userData.token);
            emit(UserAuthenticated(
              user: User(
                id: userData.id,
                token: userData.token,
                username: userData.username,
                email: userData.email
              )
            ));
          }
        );

      } catch (error) {
        print(error.toString());
      }
    } else {
      emit(UserUnauthenticated());
    }
  }

  void _onLogout(LogoutUser event, Emitter<UserState> emit) {
    emit(UserUnauthenticated());
  }
}