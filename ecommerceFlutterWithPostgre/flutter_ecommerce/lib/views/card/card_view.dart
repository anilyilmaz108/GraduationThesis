import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/category_model.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/card/component/list_tile_item.dart';
import 'package:flutter_ecommerce/views/card/credit_card_view.dart';
import 'package:flutter_ecommerce/views/card/payment_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFF2),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
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
                      "Sepete Ürün Eklemek İçin Lütfen Giriş Yapınız",
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
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.93,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFFC2792A),
                              Colors.orangeAccent,
                            ]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Center(
                              child: Text(
                            '${DataService.selectedProductList.length} Ürün Mevcut',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ))),
                    ),
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          DataService.selectedProductList.length, (i) {
                        DataService.selectedProductList[i].productNumber =
                            DataService.selectedProductList[i].productNumber;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                                "${DataService.selectedProductList[i].title}"),
                            subtitle: Text(
                                "₺${DataService.selectedProductList[i].price}"),
                            leading: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF3AE48),
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${DataService.selectedProductList[i].image}"),
                                      fit: BoxFit.fill)),
                            ),
                            trailing: Container(
                              width: 110,
                              child: Row(
                                children: <Widget>[
                                  DataService.selectedProductList[i]
                                              .productNumber !=
                                          0
                                      ? IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {

                                              DataService.selectedProductList[i]
                                                  .productNumber = (DataService
                                                      .selectedProductList[i]
                                                      .productNumber! -
                                                  1);
                                              print(DataService
                                                  .selectedProductList[i]
                                                  .productNumber);
                                              //price -= widget.cost!;
                                              DataService
                                                  .totalCost = DataService
                                                      .totalCost -
                                                  DataService
                                                      .selectedProductList[i]
                                                      .price!;

                                              print(
                                                  "COST::: ${DataService.selectedProductList[i].productNumber}");
                                              //print("PRICE::: $price");
                                              print(
                                                  "DATASERVICE PRICE::: ${DataService.totalCost}");

                                            });
                                          },
                                        )
                                      : Container(),
                                  Text(DataService
                                      .selectedProductList[i].productNumber
                                      .toString()),
                                  IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          DataService.selectedProductList[i]
                                              .productNumber = (DataService
                                                  .selectedProductList[i]
                                                  .productNumber! +
                                              1);
                                          //price += widget.cost!;
                                          DataService.totalCost =
                                              DataService.totalCost +
                                                  DataService
                                                      .selectedProductList[i]
                                                      .price!;
                                          print(
                                              "COST::: ${DataService.selectedProductList[i].price}");
                                          //print("PRICE::: $price");
                                          print(
                                              "DATASERVICE PRICE::: ${DataService.totalCost}");
                                        });
                                      })
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),
                    DataService.selectedProductList.length == 0 || DataService.totalCost == 0.0
                        ? Text('')
                        : Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreditCardView()));
                                  DataService.productStringArray.clear();

                                  for (int i = 0; i < DataService.selectedProductList.length; i++) {
                                    DataService.productStringArray.add([
                                      DataService.selectedProductList[i].title!,
                                      DataService.selectedProductList[i].subtitle!,
                                      DataService.selectedProductList[i].price!.toString(),
                                      DataService.selectedProductList[i].type!,
                                      DataService.selectedProductList[i].image!,
                                      DataService.selectedProductList[i].size!,
                                      DataService.selectedProductList[i].productNumber!.toString(),
                                      DataService.selectedProductList[i].gender!
                                    ]);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                    shape: const StadiumBorder()),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child: Icon(
                                        Icons
                                            .keyboard_double_arrow_right_rounded,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                        "Satın Al (₺${DataService.totalCost.toStringAsFixed(2)})",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          )
                  ],
                )),
    );
  }
}


