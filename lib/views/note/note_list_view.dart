import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/services/crud/notes_services.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/delete_dailog.dart';

typedef NoteCallBack = void Function(DatabaseNote note);

class NoteListView extends StatelessWidget {
  final List<DatabaseNote> notesList;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NoteListView({
    super.key,
    required this.notesList,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notesList[index];
        return Column(
          children: [
            ListTile(
              onTap: () {
                onTap(note);
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('${note.userId} ${note.id}'),
              trailing: IconButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: Icon(Icons.delete),
              ),
            ),
            const Divider(),
          ],
        );
      },
      itemCount: notesList.length,
    );
  }
}
