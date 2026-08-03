import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.delete,
    content: context.loc.delete_note_prompt,
    optionsBuilder:() => {           // in here passing a map with String and bool
      context.loc.cancel:false,
      context.loc.yes:true,
    },
  ).then((value) => value ?? false,);
} 