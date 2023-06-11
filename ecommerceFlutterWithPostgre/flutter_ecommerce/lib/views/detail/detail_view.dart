import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/models/selected_product_model.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/detail/component/color_dot.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.product}) : super(key: key);

  final SampleModel product;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool small = true;
  bool medium = false;
  bool large = false;

  String size = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFF2),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        actions: [
          FirebaseAuth.instance.currentUser!.isAnonymous
              ? Container()
              : DataService.favItem.where((element) => element.title!.contains(widget.product.title.toString())).isNotEmpty ? Container() : IconButton(
            onPressed: () {
              Provider.of<DatabaseService>(context,listen: false).postFav(FirebaseAuth.instance.currentUser!.uid.toString(), widget.product.id.toString());
              final snackBar = SnackBar(
                content: Text('${widget.product.title} favorilere eklendi}'),
                backgroundColor: Colors.orange,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                "assets/icons/Heart.svg",
                height: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.network(
                "${widget.product.image}",
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.product.title}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "₺${widget.product.price}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          widget.product.subtitle.toString(),
                        ),
                      ),
                      /*Text(
                        "Beden",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),*/
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${widget.product.gender}",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Row(
                            children:  [
                              ColorDot(
                                isActive: small,
                                text: "S",
                                onTap: (){
                                  setState(() {
                                    small = true;
                                    medium = false;
                                    large = false;
                                  });
                                },
                              ),
                              ColorDot(
                                isActive: medium,
                                text: "M",
                                onTap: (){
                                  setState(() {
                                  small = false;
                                  medium = true;
                                  large = false;
                                  });
                                },
                              ),
                              ColorDot(
                                isActive: large,
                                text: "L",
                                onTap: (){
                                  setState(() {
                                  small = false;
                                  medium = false;
                                  large = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      FirebaseAuth.instance.currentUser!.isAnonymous
                          ? Container()
                          : Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if(small == true){
                                size = "Small";
                              }
                              else if(medium == true){
                                size = "Medium";
                              }
                              else if(large == true){
                                size = "Large";
                              }
                              else{
                                size = "Small";
                              }


                              DataService.selectedProductList.add(SelectedProductModel(
                                id: widget.product.id,
                                type: widget.product.type,
                                subtitle: widget.product.subtitle,
                                title: widget.product.title,
                                userid: FirebaseAuth.instance.currentUser?.uid.toString(),
                                productNumber: 1,
                                size: size,
                                image: widget.product.image,
                                price: widget.product.price,
                                gender: widget.product.gender
                              ));
                              DataService.totalCost += widget.product.price!;

                              print(DataService.selectedProductList[0].size);
                              final snackBar = SnackBar(
                                content: Text('${widget.product.title} sepete eklendi'),
                                backgroundColor: Colors.orange,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                shape: const StadiumBorder()),
                            child: const Text("Sepete Ekle", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
