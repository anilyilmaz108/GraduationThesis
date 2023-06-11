import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/views/admin/admin_view.dart';
import 'package:flutter_ecommerce/views/base_view.dart';
import 'package:flutter_ecommerce/views/intro_view.dart';
import 'package:provider/provider.dart';

class Beginning extends StatefulWidget {
  @override
  _BeginningState createState() => _BeginningState();
}

class _BeginningState extends State<Beginning> {
  bool isLogged = true;
  String? admin = 'anilyilmaz108@gmail.com';
  bool isAdmin = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLogged = false;
          isAdmin = false;
        });
      } else {
        print('User is signed in!');
        if (user.email == '$admin') {
          print('Admin is signed in!');
          setState(() {
            isLogged = true;
            isAdmin = true;
          });
        } else {
          setState(() {
            isLogged = true;
            isAdmin = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: Provider.of<AuthService>(context, listen: false).authStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? isAdmin == true
                    ? AdminView()
                    : BaseView()
                : IntroView();
          } else {
            return SizedBox(
              width: 300,
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
