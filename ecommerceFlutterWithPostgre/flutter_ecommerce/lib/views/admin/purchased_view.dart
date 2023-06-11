import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/purchased_model.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class PurchasedView extends StatefulWidget {
  const PurchasedView({Key? key}) : super(key: key);

  @override
  State<PurchasedView> createState() => _PurchasedViewState();
}

class _PurchasedViewState extends State<PurchasedView> {
  late TextEditingController _controller;

  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getDataPurchased();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller = TextEditingController();
    super.dispose();
  }
  //List<SampleModel> searchList = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satış Takip'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 20, color: Colors.black54,),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<PurchasedModel>>(
            future: Provider.of<DatabaseService>(context,listen: false).getDataPurchased(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data?.length == 0
                    ? Center(child: Text('Herhangi bir veri bulunamadı'),)
                    : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: snapshot.data?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          DateTime snapshotDatetime = DateTime.parse('${snapshot.data?[index].date}');
                          print(snapshot.data?.length);
                          return GestureDetector(
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0)
                                  ),
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Text('Müşteri                        ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 20,),
                                            Flexible(child: Text('${snapshot.data![index].customer}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                          ],
                                        ),
                                        const SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Text('Toplam Tutar             ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 20,),
                                            Flexible(child: Text('₺${snapshot.data![index].amount}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                          ],
                                        ),
                                        const SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Text('Müşteri Adresi          ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 20,),
                                            Flexible(child: Text('${snapshot.data![index].address}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                          ],
                                        ),
                                        const SizedBox(height: 3,),
                                        Text('Satın Alınanlar', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Adı               ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][0]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Açıklaması', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][1]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Fiyatı           ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('₺${snapshot.data![index].products[0][2]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Türü              ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][3]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Linki             ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][4]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Bedeni        ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][5]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Adedi          ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][6]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:  [
                                              Text('- Ürün Cinsiyeti     ', style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Flexible(child: Text('${snapshot.data![index].products[0][7]}', style: TextStyle(color: Colors.black,fontSize: 12))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_month,color: Colors.black, size: 14,),
                                            SizedBox(width: 3,),
                                            Flexible(child: Text('${snapshotDatetime.day}/${snapshotDatetime.month}/${snapshotDatetime.year}',style: TextStyle(fontSize: 12),)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ),);
  }
}
