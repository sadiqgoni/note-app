
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apptutorial/bloc/note_bloc.dart';
import 'package:apptutorial/models/note_model.dart';
import 'package:apptutorial/view/task_details.dart';
import 'package:apptutorial/view/task_page.dart';
import '../service/firestore_service.dart';
import '../widget/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => NoteBloc(firestoreService)..add(LoadNotes()),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              return StreamBuilder<List<Note>>(
                stream: firestoreService.getNoteStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading notes'));
                  }
                  final notes = snapshot.data ?? [];
                  if (notes.isEmpty) {
                    return const Center(child: Text('No Data Available!!'));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: notes.length,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                title: note.title,
                                description: note.description,
                              ),
                            ),
                          );
                        },
                        child: CardWidget(
                          title: note.title,
                          description: note.description,
                          onDelete: () async {
                            final success =
                                await firestoreService.deleteNote(id: note.id);
                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Failed to delete note')),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TaskScreen()));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
