import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/views/login-register/component/my_raised_button.dart';
import 'package:flutter_ecommerce/views/login-register/register_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AuthService>(context,listen: false).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.code);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AuthService>(context,listen: false).signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.code);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              Provider.of<AuthService>(context,listen: false).SignOut();
              print('logout tıklandı');
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                      image: AssetImage("assets/images/applogo.png",)
                    )
                  ),
                ),


                SizedBox(height: 60,),
                Text('GiysiDolabı', style: TextStyle(fontSize: 25)),
                SizedBox(height: 20),
                MyRaisedButton(
                  color: Colors.red,
                  child: Text("Anonim Olarak Giriş Yap",),
                  onPressed: _isLoading ? null : _signInAnonymously,
                ),
                SizedBox(height: 10),
                MyRaisedButton(
                  color: Colors.yellow,
                  child: Text("Email/Parola ile Giriş Yap",),
                  onPressed: _isLoading
                      ? null
                      : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterView()));
                  },
                ),
                SizedBox(height: 10),
                MyRaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text("Google ile Giriş Yap"),
                  onPressed: _isLoading ? null : _signInWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(String errorText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
