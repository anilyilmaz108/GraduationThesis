import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/notification_service.dart';
import 'package:flutter_ecommerce/views/beginning.dart';
import 'package:flutter_ecommerce/views/card/card_view.dart';
import 'package:flutter_ecommerce/views/favourite/favourite_view.dart';
import 'package:flutter_ecommerce/views/home/home_view.dart';
import 'package:flutter_ecommerce/views/profile/profile_view.dart';
import 'package:flutter_ecommerce/views/settings/settings_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView>{
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    CardView(),
    FavouriteView(),
    ProfileView(),
    SettingsView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> appbarTitleList = [
    "GiysiDolabı","Sepetim","Favoriler","Profil","Ayarlar"
  ];

  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).requestPermission();
    Provider.of<NotificationService>(context, listen: false).loadFCM();
    Provider.of<NotificationService>(context, listen: false).listenFCM();
    //getToken();
    FirebaseMessaging.instance.subscribeToTopic("ecommerce");
    FirebaseAuth.instance.currentUser!.displayName == null ? null : FirebaseAuth.instance.currentUser!.isAnonymous ? null : Provider.of<NotificationService>(context, listen: false).sendPushMessage("Dolabım Ailesine Hoşgeldiniz", "${FirebaseAuth.instance.currentUser!.displayName}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Sepetim",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,),
            label: "Favoriler",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: "Profil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,),
            label: "Ayarlar",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  PreferredSizeWidget _buildAppBar(int index) {
    return AppBar(
      //centerTitle: true,
      title: Text(
        appbarTitleList[index],
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      actions: [
        IconButton(
            onPressed: (){
              Provider.of<AuthService>(context, listen: false).SignOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Beginning(

                )),
                    (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.black26,)
        ),
      ],
    );
  }
}



