import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_event.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.verify_email)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
context.loc.verify_email_view_prompt,
              ),
              SizedBox(height: 10),
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
                child: Text(context.loc.verify_email_send_email_verification),
              ),
              ElevatedButton(
                onPressed: () async {
                  checkEmailVerified();
                },
                child: Text('Check is Email Verified'),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: Text(context.loc.restart),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    await user?.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;
    developer.log(refreshedUser.toString());
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
