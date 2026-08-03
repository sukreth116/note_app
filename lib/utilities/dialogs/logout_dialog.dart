import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.logout_button,
    content: context.loc.logout_dialog_prompt,
    optionsBuilder:() => {
      context.loc.cancel:false,
      context.loc.yes:true,
    },
  ).then((value) => value ?? false,);
}