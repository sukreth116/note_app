import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/screen_functions.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email verification screen')),
      body: SafeArea(
        child: Column(
          children: [
            Text('You have to verify email here'),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: Text('Send verification mail'),
            ),
            ElevatedButton(
              onPressed: () {
                userLogout(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
