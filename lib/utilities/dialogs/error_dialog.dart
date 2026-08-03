import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) async {
  return showGenericDialog(
    context: context,
    title: context.loc.generic_error_prompt,
    content: text,
    optionsBuilder: () {
      return {context.loc.ok: null};
    },
  );
}
