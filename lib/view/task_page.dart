import 'package:apptutorial/service/firestore_service.dart';
import 'package:flutter/material.dart';
import '../widget/form_input.dart';

class TaskScreen extends StatefulWidget {

  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 20),
                Icon(Icons.delete),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InputFieldWidget(
                  label: 'Task Title',
                  info: 'Enter your title',
                  controller: _titleController,
                ),
                const SizedBox(height: 10),
                InputFieldWidget(
                  label: 'Task Description',
                  info: 'Enter your description',
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints.expand(height: 50, width: 200),
                  child: ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        try{
                          setState(() {
                            isLoading = true;
                          });
                          await firestoreService.addNote(title: _titleController.text, description: _descriptionController.text);
                          setState(() {
                            isLoading = false;
                            _titleController.clear();
                            _descriptionController.clear();
                          });
                        }catch (e){
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: isLoading == true ? const CircularProgressIndicator(
                      color: Colors.white,
                    ) : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
