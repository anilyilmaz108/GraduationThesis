import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/beginning.dart';

class SplashView extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Beginning())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset('assets/images/applogo.png')
    );
  }
}