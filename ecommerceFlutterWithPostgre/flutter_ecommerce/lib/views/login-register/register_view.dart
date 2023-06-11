import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/image_service.dart';
import 'package:flutter_ecommerce/views/beginning.dart';
import 'package:provider/provider.dart';


enum FormStatus { signIn, register, reset }

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscure = true;
  String? userName;
  File? file;
  final _signInFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  @override

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscure = !_obscure;
    });
  }


  FormStatus _formStatus = FormStatus.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: _formStatus == FormStatus.signIn
                ? buildSignInForm()
                : _formStatus == FormStatus.register
                    ? buildRegisterForm()
                    : buildResetForm(),
          ),
        ),
      ),
    );
  }

  Widget buildSignInForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Giriş Yap",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return "Geçerli bir email adresi giriniz.";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-Mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if(value!=null){
                  if (value.length < 6) {
                    return "Parola 6 karakterden daha az olamaz.";
                  } else {
                    return null;
                  }
                }
              },
              obscureText: _obscure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscure == true ? Colors.grey : Colors.blue,
                    ),
                    onPressed: _toggle),
                prefixIcon: Icon(Icons.lock),
                hintText: "Parola",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_signInFormKey.currentState!.validate()) {}
                final user = await Provider.of<AuthService>(context,listen: false).signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text);
                if (!user!.emailVerified) {
                  await _showMyDialog();
                  Provider.of<AuthService>(context,listen: false).SignOut();
                }
                Navigator.pop(context);
              },
              child: Text("Giriş",),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.register;
                });
              },
              child: Text("Yeni bir hesap oluşturmak için tıklayın",),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.reset;
                });
              },
              child: Text("Şifremi unuttum",),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kayıt Ol",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _userNameController,
              validator: (value) {
                if (value!.length < 1) {
                  return "Kullanıcı adı boş bırakılamaz";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_rounded),
                hintText: "Kullanıcı adı",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return "Email adresiniz hatalı";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-Mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if(value!=null){
                  if (value.length < 6) {
                    return "Parola 6 karakterden daha az olamaz";
                  } else {
                    return null;
                  }
                }
              },
              obscureText: _obscure,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscure == true ? Colors.grey : Colors.orange,
                    ),
                    onPressed: _toggle),
                hintText: "Parola",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordConfirmController,
              validator: (value) {
                if (value != _passwordController.text) {
                  return "Parolalar eşleşmedi";
                } else {
                  return null;
                }
              },
              obscureText: _obscure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscure == true ? Colors.grey : Colors.orange,
                    ),
                    onPressed: _toggle),
                prefixIcon: Icon(Icons.lock),
                hintText: "Onayla",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_registerFormKey.currentState!.validate()) {
                  final user = await Provider.of<AuthService>(context,listen: false).CreateUserWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                      _userNameController.text);

                  await _showMyDialog();
                  Provider.of<AuthService>(context,listen: false).SignOut();

                  setState(() {
                    _formStatus = FormStatus.signIn;
                  });


                }
              },
              child: Text("Kayıt Ol"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.signIn;
                });
              },
              child: Text("Zaten üye misin? Giriş yap"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResetForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _resetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Şifre Yenileme",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return "Email adresiniz hatalı";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-Mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_resetFormKey.currentState!.validate()) {
                  await Provider.of<AuthService>(context,listen: false).sendPasswordResetEmail(_emailController.text);
                  await _showResetPasswordDialog();
                  Navigator.pop(context);
                  //print(user.emailVerified);
                }
              },
              child: Text("Onayla",),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("GiysiDolabı",),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Merhaba, Ecommerce app uygulamasına hoşgeldiniz",),
                Text("Tarzına en uygun ürünleri görebilirsin",),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Anladım",),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Beginning()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetPasswordDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Şifre Yenileme",),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Merhaba, mail adresinizi kontrol edin.",),
                Text("Linke tıklayarak şifrenizi değiştirebilirsiniz.",),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Anladım",),
              onPressed: () {
                Provider.of<AuthService>(context,listen: false).sendPasswordResetEmail(_emailController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
