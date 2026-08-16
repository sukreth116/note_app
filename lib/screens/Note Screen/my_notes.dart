import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/constants/routes.dart';
import 'package:flutter_tutorial_first_sample_project/enums/menu_action.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_note_model.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_storage_firebase_crud.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/logout_dialog.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/screen_functions.dart';
import 'package:flutter_tutorial_first_sample_project/screens/Note%20Screen/create_update_note.dart';
import 'package:flutter_tutorial_first_sample_project/screens/Note%20Screen/note_list_view.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class MyNotes extends StatefulWidget {
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  late final FirebaseCloudStorage _notesServices;
  String get userId => AuthServices.firebase().currentUser!.id;

  @override
  void initState() {
    _notesServices = FirebaseCloudStorage();
    // _notesServices.open();
    super.initState();
  }

  // This is the starting point when we create an instance factory contructor
  // NotesServices and NotesServices._sharedInstance trigger

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _notesServices.getAllNotes(ownerUserId: userId).getLength,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              final noteCount = asyncSnapshot.data ?? 0;
              final text = context.loc.notes_title(noteCount);
              return Text(text);
            } else {
              return const Text('No Notes');
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return CreateUpdateNote();
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await userLogout(context);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text(context.loc.logout_button),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _notesServices.getAllNotes(ownerUserId: userId),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (asyncSnapshot.hasData) {
                final allNotes = asyncSnapshot.data as Iterable<CloudNote>;
                return NoteListView(
                  // in here we are calling NoteListView. So the arguments are passed. as like the onTap parameter expect a function.
                  onTapFunction: (CloudNote note) {
                    // so we pass a anonymous function definition in that anonymous function parameter is DatabaseNote note
                    Navigator.of(
                      // so like onTap we pass onDelete
                      context,
                    ).pushNamed(createOrUpdateRoute, arguments: note);
                  },
                  notesList: allNotes,
                  onDeleteNote: (note) async {
                    await _notesServices.deleteNote(
                      documentId: note.documentId,
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
