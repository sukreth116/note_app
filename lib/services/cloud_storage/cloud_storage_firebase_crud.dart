import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_note_model.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_storage_constants.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');
  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNoteUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> getAllNotes({required String ownerUserId}) {
    final allNotes = notes
        .where(onwerUserIdField, isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)),
          // .where((note) => note.userId == ownerUserId),
        );
    return allNotes;
  }

  // commenting this because currently not using
  // Future<Iterable<CloudNote>> getNote({required String ownerUserId}) async {
  //   try {
  //     return await notes
  //         .where(onwerUserIdField, isEqualTo: ownerUserId)
  //         .get()
  //         .then(
  //           (value) => value.docs.map((doc) {
  //             return CloudNote(
  //               documentId: doc.id,
  //               userId: doc.data()[onwerUserIdField] as String,
  //               text: doc.data()[textFieldName] as String,
  //             );
  //           }),
  //         );
  //   } catch (e) {
  //     throw CouldNotGetAllNoteException();
  //   }
  // }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      onwerUserIdField: ownerUserId,
      textFieldName: '',
    });
    final fetchNote = await document.get();
    return CloudNote(documentId: fetchNote.id, userId: ownerUserId, text: '');
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance(); // is the constructor declaration, not a constructor call.

  factory FirebaseCloudStorage() => _shared;
}
