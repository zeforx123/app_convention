import 'package:app_convention/bloc/auth/aut_gate.dart';
import 'package:app_convention/bloc/auth/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppConventionApp());
}

class AppConventionApp extends StatelessWidget {
  const AppConventionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'App Convention',
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    );
  }
}
