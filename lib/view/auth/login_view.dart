import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_2/bloc/user/user_bloc.dart';
import 'package:test_2/view/components/my_button.dart';
import 'package:test_2/view/components/my_textfield.dart';

class LoginView extends StatefulWidget {

  const LoginView({
    super.key
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserAuthenticated) {
              //context.go('/home');
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
              
                  const SizedBox(height: 25),
              
                  //app name
                  const Text(
                    "M I N I M A L",
                    style: TextStyle(fontSize: 20),
                  ),
              
                  const SizedBox(height: 50),

                  //email textfield
                  MyTextfield(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController
                  ),

                  const SizedBox(height: 10),

                  //password textfield
                  MyTextfield(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController
                  ),

                  const SizedBox(height: 10),

                  //forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Olvidaste tu contraseña?",
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    text: "Iniciar Session",
                    onTap: () { 
                      userBloc.add(LoginUser(email: emailController.text, password: passwordController.text));
                    }
                  ),

                  const SizedBox(height: 25),

                  //dont have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No tienes una cuenta?",
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                      ),
                      GestureDetector(
                        onTap: () {context.go('/register');},
                        child: const Text(
                          " Registrarse",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}