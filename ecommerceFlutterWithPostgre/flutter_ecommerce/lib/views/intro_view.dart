import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/login-register/login_view.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';


class IntroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = [
      PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        body: Text("Ürünleri incele"),
        title: Text("Ürünleri Seç"),
        titleTextStyle:
        const TextStyle(color: Colors.white),
        bodyTextStyle: const TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/images/explore.jpeg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        ),
      ),
      PageViewModel(
        pageColor: const Color(0xFF8BC34A),
        body: Text("Sepete eklenen ürünlerin siparişini ver"),
        title: Text("Siparişini Ver"),
        mainImage: Image.asset(
          'assets/images/product_1.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        ),
        titleTextStyle:
        const TextStyle(color: Colors.white),
        bodyTextStyle: const TextStyle(color: Colors.white),
      ),
      PageViewModel(
        pageBackground: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated,
              colors: [
                Colors.orange,
                Colors.purpleAccent,
              ],
            ),
          ),
        ),
        body: Text("Verdiğiniz siparişleri size en uygun şekilde ödeyin"),
        title: Text("Kolayca Öde"),
        mainImage: Image.asset(
          'assets/images/payment.jpeg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        ),
        titleTextStyle:
        const TextStyle(color: Colors.white),
        bodyTextStyle: const TextStyle(color: Colors.white),
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GiysiDolabı",
        theme: ThemeData(
          //scaffoldBackgroundColor: Colors.orange,
          primarySwatch: Colors.orange,
          fontFamily: "Gordita",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ) ,
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          doneText: Text("Tamam"),
          nextText: Text("İleri"),
          backText: Text("Geri"),
          skipText: Text("Atla"),
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginView()),
            );
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

