import 'package:flutter/material.dart';
import 'package:home/packages/flutter_login/flutter_login.dart';
import 'package:home/services/auth.dart';
import 'package:home/navigation.dart';

class LoginScreen extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        errorColor: Colors.black,
        authButtonPadding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        pageColorLight: const Color(0xFFF5F1EB),
        primaryColor: Color.fromARGB(255, 126, 124, 119),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 162, 160, 149),
        ),
        accentColor: const Color.fromARGB(255, 154, 150, 150),
        pageColorDark: const Color(0xfff6f4ef),
        logoWidth: 0.5,
        titleStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 30,
        ),
      ),
      title: "Smart Home\nDevice Application",
      onLogin: _auth.signInWithEmailAndPassword,
      onSignup: _auth.registerWithEmailAndPassword,
      // loginProviders: [
      //   LoginProvider(
      //     icon: FontAwesomeIcons.google,
      //     callback: _auth.signInWithGoogle,
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.instagram,
      //     callback: _auth.signInWithGoogle,
      //   ),
      // ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Navigation(),
          ),
        );
      },
      onRecoverPassword: _auth.recoverPassword,
      // footer: "Designed and Developed by Devang Shukla",
      messages: LoginMessages(
        recoverPasswordDescription:
            'Enter your email to receive a link to reset your password',
      ),
    );
  }
}
