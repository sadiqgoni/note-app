import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apptutorial/models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> addNote({
    required String title,
    required String description,
  }) async {
    try {
      await _db.collection('notes').add({
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<List<Note>> getNotes() async {
    try {
      final response = await _db.collection('notes').get();
      return response.docs.map(
            (document) {
          final data = document.data();
          return Note(
            id: document.id,
            title: data['title'],
            description: data['description'],
            createdAt: data['createdAt'].toDate(),
          );
        },
      ).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Stream<List<Note>> getNoteStream() {
    return _db
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (e) {
          final data = e.data();
          return Note(
            id: e.id,
            title: data['title'],
            description: data['description'],
            createdAt: data['createdAt'].toDate(),
          );
        },
      ).toList(),
    );
  }

  Future<bool> deleteNote({
    required String id,
  }) async {
    try {
      await _db.collection('notes').doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
}

FirestoreService firestoreService = FirestoreService();
