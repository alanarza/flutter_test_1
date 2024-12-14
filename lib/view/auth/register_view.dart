import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_2/repositories/user_repository.dart';
import 'package:test_2/view/components/my_button.dart';
import 'package:test_2/view/components/my_popup.dart';
import 'package:test_2/view/components/my_textfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final UserRepository _userRepository = UserRepository();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async {

    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );

    //username not null
    if(usernameController.text == "") {
      if (context.mounted) Navigator.pop(context);
      MyPopup("El nombre de usuario es obligatorio!", context);
    } else if(emailController.text == "") {
      if (context.mounted) Navigator.pop(context);
      MyPopup("El email es obligatorio!", context);
    } else if(passwordController.text == "" || passwordController.text != confirmPwController.text) {
      if (context.mounted) Navigator.pop(context);
      MyPopup("Las contraseñas no coinciden!", context);
    } else {

      try {
        final result = await _userRepository.register(
          usernameController.text, 
          emailController.text,
          passwordController.text,
          confirmPwController.text
        );

        result.fold(
          (error) => print('Error: $error'),
          (success) {
            if (context.mounted) Navigator.pop(context);
            print('Success: $success');
            context.go('/login');
          }
        );

      } catch(error) {
        if (context.mounted) Navigator.pop(context);
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
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
          
              //username textfield
              MyTextfield(
                hintText: "Nombre de usuario",
                obscureText: false,
                controller: usernameController
              ),

              const SizedBox(height: 10),

              //email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController
              ),

              const SizedBox(height: 10),

              //password textfield
              MyTextfield(
                hintText: "Contraseña",
                obscureText: true,
                controller: passwordController
              ),

              const SizedBox(height: 10),

              //confirm password textfield
              MyTextfield(
                hintText: "Confirmar contraseña",
                obscureText: true,
                controller: confirmPwController
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

              //register in button
              MyButton(
                text: "Registrarse",
                onTap: registerUser
              ),

              const SizedBox(height: 25),

              //dont have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tienes una cuenta?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                  GestureDetector(
                    onTap: () {context.go('/login');},
                    child: const Text(
                      " Inicia session",
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
      )
    );
  }
}