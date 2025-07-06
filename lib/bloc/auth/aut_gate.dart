import 'package:app_convention/screens/home.dart';
import 'package:app_convention/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          print("Usuario logeado");
          return const Home(); // Usuario logeado
        } else {
          print("Usuario no logeado");
          return const LoginScreen(); // Usuario no logeado
        }
      },
    );
  }
}
