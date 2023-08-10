import 'package:apptutorial/service/firestore_service.dart';
import 'package:apptutorial/view/task_details.dart';
import 'package:apptutorial/view/task_page.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../widget/card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Color> colors = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.brown
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Note>>(
          future: firestoreService.getNotes(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
            }else if(!snapshot.hasData){
              return const Center(child: Text('No data available at the moment!!!'),);
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            return snapshot.data!.isEmpty ? const Center(child: Text('No note add yet!!!')) : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, index) {
                  final note = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            color: colors[index],
                            title: note.title,
                            description: note.description,
                          ),
                        ),
                      );
                    },

                    child: CartWidget(
                        title: note.title,
                        description: note.description,
                        ),
                  );
                },);
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  const TaskScreen()));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
