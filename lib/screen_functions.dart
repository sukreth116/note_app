import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/firebase_options.dart';
import 'package:flutter_tutorial_first_sample_project/login.dart';

void showErrorMessage(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // padding: EdgeInsets.all(10),
    ),
  );
}

Future<void> initializeWithDelay() async {
  // await Future.delayed(Duration(seconds: 3)); // fake delay
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> userLogout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) {
        return LoginScreen();
      },
    ),
    (Route<dynamic> route) => false,
  );
}
