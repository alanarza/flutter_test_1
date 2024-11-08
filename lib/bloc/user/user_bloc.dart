import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_2/models/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginUser>(_onLogin);
    on<LogoutUser>(_onLogout);
  }

  void _onLogin(LoginUser event, Emitter<UserState> emit) async {
    
    emit(UserLoading());

    /*
    try {
      //getting user credentials
      final response = await apiLoginUser(
        event.email,
        event.password,
      );

      //validate response status
      validateResponseStatus(response);
    } on HttpException catch (e) {
      throw Exception(e);
    }*/

    // Aquí podrías realizar la lógica de autenticación
    /*if (event.email == 'john.doe@example.com' && event.password == 'password123') {
      emit(UserAuthenticated(
        user: User(
          id: 1,
          token: 'token',
          username: 'John Doe',
          email: 'email'
          )
        )
      );
    } else {
      emit(UserUnauthenticated());
    }*/
  }

  void _onLogout(LogoutUser event, Emitter<UserState> emit) {
    emit(UserUnauthenticated());
  }
}