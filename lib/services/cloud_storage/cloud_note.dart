import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tutorial_first_sample_project/services/cloud_storage/cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String userId;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.userId,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    : documentId = snapshot.id,
      userId = snapshot.data()[onwerUserIdField],
      text = snapshot.data()[textFieldName] as String;
}
