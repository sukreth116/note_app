import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'logout',
    content: 'Are you sure, do you want to logout?',
    optionsBuilder:() => {
      'Cancel':false,
      'Log out':true,
    },
  ).then((value) => value ?? false,);
}