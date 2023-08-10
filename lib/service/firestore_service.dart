import 'package:apptutorial/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> addNote(
      {required String title, required String description}) async {
    try {
      await _db.collection('notes').doc().set({
        'title': title,
        'description': description,
      });
      return true;
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<List<Note>> getNotes() async {
    try {
      final response = await _db.collection('notes').get();
      return response.docs
          .map(
            (document) => Note(
              title: document.data()['title'],
              description: document.data()['description'],
            ),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
}

FirestoreService firestoreService = FirestoreService();
