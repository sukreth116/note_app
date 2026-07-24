import 'package:flutter/cupertino.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) async {
  return showGenericDialog<void>(
    context: context,
    title: 'Error Occured',
    content: 'Cannot share empty data',
    optionsBuilder: () => {'OK': null},
  );
}
