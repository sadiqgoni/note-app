import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String label;
  final String info;
  final TextEditingController controller;

  const InputFieldWidget({
    super.key,
    required this.label,
    required this.info,
    required this.controller,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              validator: (val){
                if(val!.isEmpty){
                  return '${widget.label} is required';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(width: 1, color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(4),
                ),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red,
                    )),
                filled: true,
                labelText: widget.info,
                fillColor: const Color.fromRGBO(247, 249, 251, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
