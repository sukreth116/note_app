import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/login.dart';
import 'package:flutter_tutorial_first_sample_project/my_notes.dart';
import 'package:flutter_tutorial_first_sample_project/routes.dart';
import 'package:flutter_tutorial_first_sample_project/screen_functions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeWithDelay(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              print('now have a user that is $user');
              if (user != null) {
                if (user.emailVerified) {
                  return MyNotes();
                  // print('email verified');
                } else {
                  return EmailVerification();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ctx) {
                  //       return EmailVerification();
                  //     },
                  //   ),
                  // );
                }
              } else {
                return LoginScreen();
              }
            // return Text('Done home reached');
            default:
              return Text('Loading please wait');
          }
        },
      ),
    );
  }
}
