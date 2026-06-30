import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/views/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/views/login.dart';
import 'package:flutter_tutorial_first_sample_project/views/my_notes.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/screen_functions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthServices.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthServices.firebase().currentUser;
              print('now have a user that is $user');
              if (user != null) {
                if (user.isEmailVerified) {
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
