import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/generics/get_arguments.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_note_model.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_storage_firebase_crud.dart';

class CreateUpdateNote extends StatefulWidget {
  const CreateUpdateNote({super.key});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesServices;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesServices = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  Future<void> _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesServices.updateNote(documentId: note.documentId, text: text);
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }

    final currentUser = AuthServices.firebase().currentUser!;
    final newNote = await _notesServices.createNewNote(
      ownerUserId: currentUser.id,
    );

    _note = newNote;
    return newNote;
  }

  void saveOrDeleteNote() {
    final note = _note;
    if (note != null) {
      if (_textController.text.isEmpty) {
        _notesServices.deleteNote(documentId: note.documentId);
      } else {
        _notesServices.updateNote(
          documentId: note.documentId,
          text: _textController.text,
        ); // this updateNote called here is not necessary because it already called _textControllerListener().
      } // it listen and save note whenever the field get updated by user
    }
  }

  @override
  void dispose() {
    saveOrDeleteNote();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.note),
        actions: [
          IconButton(
            onPressed: () async {
              final text = _textController.text;
              if (_note == null || text.isEmpty) {
                await showCannotShareEmptyDialog(context);
              } else {
                SharePlus.instance.share(ShareParams(text: text));
              }
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: context.loc.start_typing_your_note,
                  ),
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
