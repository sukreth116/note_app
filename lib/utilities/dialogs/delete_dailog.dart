import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure, do you want to delete note?',
    optionsBuilder:() => {
      'Cancel':false,
      'Delete':true,
    },
  ).then((value) => value ?? false,);
}