import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/screen_functions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME PAGE')),
      body: FutureBuilder(
        future: initializeWithDelay(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              print('now have a user that is $user');
              if (user?.emailVerified ?? false) {
                return Column(
                  children: [
                    Text('Welcome to homepage'),
                    ElevatedButton(
                      onPressed: () {
                        userLogout(context);
                      },
                      child: Text('Logout'),
                    ),
                  ],
                );
              } else {
                return EmailVerification();
              }
            default:
              return Text('Loading please wait');
          }
        },
      ),
    );
  }
}
