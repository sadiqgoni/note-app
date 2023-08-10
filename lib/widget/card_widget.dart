import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/task_page.dart';

class CartWidget extends StatelessWidget {
  final String title;
  final String description;
  const CartWidget({
    super.key, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
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
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis,),
      ),
    );
  }
}
