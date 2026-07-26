import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/firebase_auth_provider.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/views/Note%20Screen/home.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/login.dart';
import 'package:flutter_tutorial_first_sample_project/views/Note%20Screen/create_update_note.dart';
import 'package:flutter_tutorial_first_sample_project/views/Note%20Screen/my_notes.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/register.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor: const Color(0xFFFF0000), // your design background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: HomePage(),
      ),
      routes: {
        homeRoute: (ctx) => HomePage(),
        notesRoute: (ctx) => MyNotes(),
        loginRoute: (ctx) => LoginScreen(),
        registerRoute: (ctx) => RegisterScreen(),
        emailVerificationRoute: (ctx) => EmailVerification(),
        createOrUpdateRoute: (ctx) => CreateUpdateNote(),
      },
    );
  }
}
