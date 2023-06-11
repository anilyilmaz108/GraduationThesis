import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/calculator_service.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/profile/component/information_row.dart';
import 'package:flutter_ecommerce/views/profile/component/my_stack.dart';
import 'package:flutter_ecommerce/views/profile/component/profile_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFF2),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyStack(
              image: 'https://i.pinimg.com/736x/de/59/4e/de594ec09881da3fa66d98384a3c72ff.jpg',
              plusCircle: true,
              onPressed: () {},
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileContainer(
                  title: "Sepet",
                  subtitle: "${DataService.selectedProductList.length}",
                  icon: Icon(FontAwesomeIcons.gift, color: const Color(
                      0xFF4646F3),),
                  bgColor: const Color(0xFFB1B1FF),
                ),
                ProfileContainer(
                  title: "Favoriler",
                  subtitle: "${DataService.favProductNumbers}",
                  icon: Icon(FontAwesomeIcons.handHoldingHeart, color: const Color(
                      0xFFD30000),),
                  bgColor: const Color(0xFFF88888),
                )
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Text("Kişisel Bilgiler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InformationRow(
                      title: "İsim :",
                      description: FirebaseAuth.instance.currentUser!.isAnonymous ? "Anonim" : "${FirebaseAuth.instance.currentUser?.displayName}",
                    ),
                    InformationRow(
                      title: "Email :",
                      description: FirebaseAuth.instance.currentUser!.isAnonymous ? "Anonim" :"${FirebaseAuth.instance.currentUser?.email}",
                    ),
                    InformationRow(
                      title: "Kayıt :",
                      description: FirebaseAuth.instance.currentUser!.isAnonymous ? "Anonim" : "${CalculatorService.profileDateTimeToString(FirebaseAuth.instance.currentUser?.metadata.creationTime)}",
                    ),
                    InformationRow(
                      title: "Kullanıcı :",
                      description: FirebaseAuth.instance.currentUser!.email.toString() == "anilyilmaz108@gmail.com" ? "Admin" :"Üye",
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black26)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





