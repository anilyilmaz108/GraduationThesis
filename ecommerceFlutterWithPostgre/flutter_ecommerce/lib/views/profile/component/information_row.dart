import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  String? title;
  String? description;


  InformationRow({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!, style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),),
          Text(description!, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}