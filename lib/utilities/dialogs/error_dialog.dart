import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) async {
  return showGenericDialog(
    context: context,
    title: 'An Error Occured',
    content: text,
    optionsBuilder: () {
      return {'Ok': null};
    },
  );
}
