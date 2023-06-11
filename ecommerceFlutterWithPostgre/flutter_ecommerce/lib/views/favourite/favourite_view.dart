import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/favourite_model.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/detail/detail_view.dart';
import 'package:flutter_ecommerce/views/home/components/product_item.dart';
import 'package:flutter_ecommerce/views/settings/component/favourite_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {


  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getDataFavourites();
    Provider.of<DatabaseService>(context,listen: false).getDataProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: FirebaseAuth.instance.currentUser!.isAnonymous
            ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Icon(FontAwesomeIcons.solidFaceSadCry, color: Colors.grey, size: 200),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Favorilere Ürün Eklemek İçin Lütfen Giriş Yapınız",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        )
            :FutureBuilder(
          future: Future.wait([
            Provider.of<DatabaseService>(context,listen: false).getDataProducts(),
            Provider.of<DatabaseService>(context,listen: false).getDataFavourites()
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {

              print(FirebaseAuth.instance.currentUser?.uid.toString());
              print(DataService.favItem.length);
              DataService.favItem.clear();

              for(int i = 0; i < snapshot.data?[1].length; i++){
                if(snapshot.data?[1][i].userid == FirebaseAuth.instance.currentUser?.uid.toString()){
                  int favIndex = snapshot.data?[1][i].favid;

                  print('==> $favIndex');
                  DataService.favItem.add(SampleModel(
                    id: snapshot.data?[0][favIndex].id, //28
                    title: snapshot.data?[0][favIndex].title,
                    price: snapshot.data?[0][favIndex].price,
                    image: snapshot.data?[0][favIndex].image,
                    subtitle: snapshot.data?[0][favIndex].subtitle,
                    type: snapshot.data?[0][favIndex].type,
                    gender: snapshot.data?[0][favIndex].gender
                  ));

                }
              }

              print(DataService.favItem.length);
              DataService.favProductNumbers = DataService.favItem.length;

              return DataService.favItem.length == 0
                  ? Center(child: Text('Ürün Eklemeye Hemen Başlayın', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 20),),)
                  : GridView.count(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: (0.7),
                padding: const EdgeInsets.all(4.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(
                  DataService.favItem.length,
                      (index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FavouriteItem(
                      title: DataService.favItem[index].title,
                      image: DataService.favItem[index].image,
                      price: DataService.favItem[index].price,
                      bgColor: const Color(0xFFEFEFF2),
                      iconPress: (){
                        Provider.of<DatabaseService>(context, listen: false).deleteFavourites("${DataService.favItem[index].id}");
                        DataService.favItem.removeAt(index);
                        setState(() {});
                      },
                      press: () {
                        print(DataService.favItem[index].title);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(product: SampleModel(
                          price: DataService.favItem[index].price,
                          image: DataService.favItem[index].image,
                          subtitle: DataService.favItem[index].subtitle,
                          title: DataService.favItem[index].title,
                          type: DataService.favItem[index].type,
                          id: DataService.favItem[index].id,
                          gender: DataService.favItem[index].gender,
                        ))));
                      },
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        )
      ),
    );
  }
}


