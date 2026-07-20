import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/services/crud/notes_services.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/generics/get_arguments.dart';

class CreateUpdateNote extends StatefulWidget {
  const CreateUpdateNote({super.key});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  // bool _isLoading = true;
  DatabaseNote? _note;
  late final NotesServices _notesServices;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesServices = NotesServices();
    _textController = TextEditingController();
    super.initState();
    // _initializeNote();
  }
  
  // Future<void> _initializeNote() async {
  //   final note = await createOrGetExistingNote(context);
  //   _note = note; // ✅ THIS IS MISSING IN YOUR CODE
  //   _setupTextControllerListener();

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<void> _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesServices.updateNote(note: note, text: text);
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> createOrGetExistingNote(BuildContext context) async {
    
    final widgetNote = context.getArgument<DatabaseNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }
    
    // ModalRoute.of(context)?.settings.arguments;

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthServices.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesServices.getOrCreateUser(email: email);
    final newNote = await _notesServices.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  // void _deleteNoteIfTextIsEmpty() {
  //   final note = _note;
  //   if (_textController.text.isEmpty && note != null) {
  //     _notesServices.deleteNote(id: note.id);
  //   }
  // }

  // Future<void> _saveNoteIfTextNotEmpty() async {
  //   final note = _note;
  //   final text = _textController.text;
  //   if (note != null && text.isNotEmpty) {
  //     await _notesServices.updateNote(note: note, text: text);
  //   }
  // }

  void saveOrDeleteNote() {
    final note = _note;
    if (note != null) {
      if (_textController.text.isEmpty) {
        _notesServices.deleteNote(id: note.id);
      } else {
        _notesServices.updateNote(note: note, text: _textController.text);
      }
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
      appBar: AppBar(title: Text('New Note')),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Start typing your notes',
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('New Note')),
  //     body: _isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : TextField(
  //             controller: _textController,
  //             keyboardType: TextInputType.multiline,
  //             maxLines: null,
  //             decoration: const InputDecoration(
  //               hintText: 'Start typing your notes',
  //             ),
  //           ),
  //   );
  // }
}
