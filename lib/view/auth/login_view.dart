import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Scaffold(
        body: Center(
          child: Text('Social Sounds!'),
        ),
      ),
    );
  }
}