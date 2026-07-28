import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_event.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EMAIL VERIFICATION')),
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
                context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
                // await AuthServices.firebase().sendEmailVerification();
                // // final user = FirebaseAuth.instance.currentUser;
                // // await user?.sendEmailVerification();  senEmailVerification is not user level anymore
              },
              child: Text('Send verification link'),
            ),
            ElevatedButton(
              onPressed: () async {
                checkEmailVerified();
              },
              child: Text('check email verified'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
              },
              child: Text('Logout and Restart'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    await user?.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;
    print(refreshedUser);
    if (refreshedUser != null && refreshedUser.emailVerified) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email not verified yet')));
    }
  }
}
