import 'package:firebasegooglesignin/Repository/authrepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthRepository _authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SizedBox(
          height: 50,
          width: 300,
          child: SignInButton(
            Buttons.Google,
            onPressed: () async {
              bool res = await _authRepository.signInWithGoogle(context);
              if (res) {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
        ),
      ),
    );
  }
}
