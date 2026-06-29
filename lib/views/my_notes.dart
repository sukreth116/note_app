import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/screen_functions.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

enum MenuAction { logout }

class _MyNotesState extends State<MyNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY NOTES'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showDialogueBar(context);
                  if (shouldLogout) {
                    await userLogout(context);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),

      body: Column(children: [Text('Welcome to homepage')]),
    );
  }
}

Future<bool> showDialogueBar(BuildContext context) async {
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

// Future<bool> showDialogueBar(BuildContext context) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (ctx) {
//       return AlertDialog(
//         title: Text('Logout!'),
//         content: Text('Are you sure do you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop(false);
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop(true);
//             },
//             child: Text('Logout', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       );
//     },
//   );
//   return result ?? false;
// }
