import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen/login_form.dart';
import 'package:flutter_tutorial_first_sample_project/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/form.dart';
import 'package:flutter_tutorial_first_sample_project/home.dart';
import 'package:flutter_tutorial_first_sample_project/login.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen/custom_background.dart';
import 'package:flutter_tutorial_first_sample_project/my_notes.dart';
import 'package:flutter_tutorial_first_sample_project/register.dart';
import 'package:flutter_tutorial_first_sample_project/routes.dart';

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
      home: HomePage(),
      routes: {
        homeRoute: (ctx) => HomePage(),
        notesRoute: (ctx) => MyNotes(),
        loginRoute: (ctx) => LoginScreen(),
        registerRoute: (ctx) => RegisterScreen(),
        emailVerificationRoute: (ctx) => EmailVerification(),
      },
    );
  }
}
