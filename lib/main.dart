import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/home.dart';
import 'package:flutter_tutorial_first_sample_project/login.dart';
import 'package:flutter_tutorial_first_sample_project/register.dart';

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
      home: const LoginScreen(),
      routes: {
        '/login/': (ctx) => LoginScreen(),
        '/register/': (ctx) => RegisterScreen(),
      },
    );
  }
}
