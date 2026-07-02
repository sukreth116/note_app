import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We've send an email verfication link to mail. Please check it",
            ),
            Text("Didn't receive the mail press the button bellow"),
            TextButton(
              onPressed: () async {
                await AuthServices.firebase().sendEmailVerification();
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();  senEmailVerification is not user level anymore
              },
              child: Text('Send verification link'),
            ),
            ElevatedButton(
              onPressed: checkEmailVerified,
              child: Text('check email verified'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthServices.firebase().logOut();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: Text('Logout and Restart'),
            ),
          ],
        ),
      ),
    );
  }

  void checkEmailVerified() {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
  }
}
