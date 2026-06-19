import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial_first_sample_project/home.dart';
import 'firebase_options.dart';
import 'package:flutter_tutorial_first_sample_project/screen_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        decoration: InputDecoration(hintText: 'Enter email'),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(hintText: 'Enter password'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await loginUser();
                        },
                        child: Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/',
                            (route) => false,
                          );
                        },
                        child: Text('Not have an account? Register here'),
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

  Future<void> loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (password.length < 6) {
      showErrorMessage(context, 'Password must contain atleast 8 characters');
    } else {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return HomePage();
            },
          ),
        );
        // print('User Credentials: $userCredential');
      } on FirebaseAuthException catch (e) {
        // print(e.code);
        if (e.code == 'invalid-credential') {
          showErrorMessage(context, 'User not found');
        } else if (e.code == 'invalid-email') {
          showErrorMessage(context, 'Invalid Email Format');
        } else if (e.code == 'wrong-password') {
          showErrorMessage(context, 'Password Do not match');
        }
      }
    }
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
