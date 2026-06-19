import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial_first_sample_project/screen_functions.dart';
import 'firebase_options.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    // _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY APP', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: FutureBuilder(
          // if not wrtten this got an exception => FirebaseException ([core/no-app] No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp())
          future: _initializeWithDelay(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'WELCOME TO MY APP',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: 'enter email'),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(hintText: 'enter password'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await registerUser();
                        },
                        child: Text('Register'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                        },
                        child: Text('Already have an account? Login'),
                      ),
                    ],
                  ),
                );
              default:
                return Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        showErrorMessage(context, 'The Password is Weak');
      }
    }

    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _initializeWithDelay() async {
    // await Future.delayed(Duration(seconds: 3)); // fake delay
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void dispose() {
    // _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
