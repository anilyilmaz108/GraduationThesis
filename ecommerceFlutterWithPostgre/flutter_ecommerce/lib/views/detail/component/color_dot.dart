import 'package:flutter/material.dart';


class ColorDot extends StatelessWidget {
   ColorDot({
    Key? key,
    required this.isActive,
    required this.text,
     required this.onTap
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? Colors.orange : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? Colors.orange : Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text, style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
