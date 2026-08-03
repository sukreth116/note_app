import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<void> showResetPasswordResetDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'we have sent an email to your account. you can reset password through the link',
    optionsBuilder: () => {'OK': null},
  );
}
