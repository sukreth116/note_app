import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/firebase_options.dart';

Future<void> showErrorMessage(BuildContext context, String errorMessage) async {
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

Future<void> showErrorDialogBox(
  BuildContext context,
  String errorMessage,
) async {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Ok'),
          ),
        ],
      );
    },
  );
}

Future<void> initializeWithDelay() async {
  // await Future.delayed(Duration(seconds: 3)); // fake delay
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> userLogout(BuildContext context) async {
  await AuthServices.firebase().logOut();
  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
}

Future<bool> showLogoutDialogBar(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Logout!'),
        content: Text('Are you sure do you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
