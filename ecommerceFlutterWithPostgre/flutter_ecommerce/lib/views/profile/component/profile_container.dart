import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileContainer extends StatelessWidget {
  String? title;
  String? subtitle;
  Icon? icon;
  Color? bgColor;


  ProfileContainer({this.title, this.subtitle, this.icon, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                ),
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(40.0)),
              ),
            ),
            Text(title!, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black54),),
            Text(subtitle!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),)

          ],
        ),
      ),
    );
  }
}