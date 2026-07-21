import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_note.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/delete_dailog.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NoteListView extends StatelessWidget {
  final Iterable<CloudNote> notesList;
  // final List<DatabaseNote> notesList;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTapFunction;

  const NoteListView({
    super.key,
    required this.notesList,
    required this.onDeleteNote,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notesList.elementAt(index);
        return Column(
          children: [
            ListTile(
              onTap: () {
                onTapFunction(
                  note,
                ); // in here we calling the passed function with the note variable as parameter
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('${note.userId} ${note.documentId}'),
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
