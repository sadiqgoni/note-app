import 'dart:async';
import 'package:apptutorial/models/note_model.dart';
import 'package:apptutorial/service/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteState {
  final List<Note> notes;

  NoteState(this.notes);
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message) : super([]);

  @override
  String toString() => 'NoteError: $message';
}

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FirestoreService firestoreService;

  NoteBloc(this.firestoreService) : super(NoteState([])) {
    on<LoadNotes>((event, emit) async {
      try {
        final notes = await firestoreService.getNotes();
        emit(NoteState(notes));
      } catch (e) {
        emit(NoteError('An error occurred while loading notes.'));
      }
    });
  }
  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is LoadNotes) {
      try {
        final notes = await firestoreService.getNotes();
        yield NoteState(notes);
      } catch (e) {
        yield NoteError('An error occurred while loading notes.');
      }
    }
  }

  Future<void> _loadNotes() async {
    try {
      final notes = await firestoreService.getNotes();
      emit(NoteState(notes));
    } catch (e) {
      // Handle error
    }
  }

}


