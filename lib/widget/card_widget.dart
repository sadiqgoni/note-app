import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;
  final void Function() onDelete;
  const CardWidget({
    super.key, required this.title, required this.description, required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.5),
          boxShadow:  const [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.black12,
                offset: Offset(0,5)
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis,),
          trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete,),
        ),
      ),
    );
  }
}
