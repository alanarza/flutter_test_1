import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_2/bloc/profile/profile_bloc.dart';
import 'package:test_2/bloc/user/user_bloc.dart';
import 'package:test_2/theme/dark_mode.dart';
import 'package:test_2/theme/light_mode.dart';
import 'package:test_2/view/auth/login_view.dart';
import 'package:test_2/view/auth/register_view.dart';
import 'package:test_2/view/home/home_view.dart';
import 'package:test_2/repositories/user_repository.dart';

void main() {
  final authStateNotifier = ValueNotifier<bool>(false);
  final userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userRepository: userRepository)
        ),
        BlocProvider(
          create: (context) => ProfileBloc(userRepository: userRepository),
        )
      ],
      child: MainApp(authStateNotifier: authStateNotifier)
    ),
  );
}

class MainApp extends StatelessWidget {
  final ValueNotifier<bool> authStateNotifier;
  
  MainApp({
    super.key, 
    required this.authStateNotifier
  });

  @override
  Widget build(BuildContext context) {

    late final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: <GoRoute>[
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) => const HomeView(),
        ),
        GoRoute(
          path: '/login',
          builder:(BuildContext context, GoRouterState state) => const LoginView(),
        ),
        GoRoute(
          path: '/register',
          builder:(BuildContext context, GoRouterState state) => const RegisterView(),
        )
      ],
      redirect: _guard,
      refreshListenable: authStateNotifier
    );

    return BlocListener<UserBloc,UserState>(
      listener: (context, state) {
        if(state is UserAuthenticated) {
          authStateNotifier.value = true;
        } else if (state is UserUnauthenticated) {
          authStateNotifier.value = false;
        }
      },
      child: MaterialApp.router(
        title: 'Social Sounds',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        routerConfig: router,
      )
    );
  }

  static String? _guard(BuildContext context, GoRouterState state) {
    final bool logginIn = state.matchedLocation == '/login';
    final bool registerIn = state.matchedLocation == '/register';

    if (context.read<UserBloc>().state is UserUnauthenticated && registerIn) {
      print("redirecciono al register");
      return '/register';
    }

    if (context.read<UserBloc>().state is UserUnauthenticated && !logginIn) {
      print("redirecciono al login");
      return '/login';
    }

    if (context.read<UserBloc>().state is UserAuthenticated && logginIn) {
      print("redirecciono al home");
      return '/home';
    }

    print("devuelvo null");
    return null;
  }
}
