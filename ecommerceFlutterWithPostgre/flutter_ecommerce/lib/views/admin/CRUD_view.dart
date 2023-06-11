import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/admin/update_products_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class CRUDView extends StatefulWidget {
  const CRUDView({Key? key}) : super(key: key);

  @override
  State<CRUDView> createState() => _CRUDViewState();
}

class _CRUDViewState extends State<CRUDView> {
  late TextEditingController _controller;

  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getDataProducts();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller = TextEditingController();
    super.dispose();
  }
  List<SampleModel> searchList = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD'),
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
          child: FutureBuilder<List<SampleModel>>(
            future: Provider.of<DatabaseService>(context,listen: false).getDataProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.length);
                return snapshot.data?.length == 0
                    ? Center(child: Text('Herhangi bir veri bulunamadı'),)
                    : SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: TextField(
                                      controller: _controller,
                                      readOnly: true,
                                      onTap: (){
                                        showSearch(
                                          context: context,
                                          delegate: SearchPage<SampleModel>(
                                            barTheme: ThemeData(
                                              primaryColor: Color(0xFFDA6F10),
                                              primarySwatch: Colors.orange,
                                            ),
                                            items: snapshot.data!,
                                            searchLabel: 'Ürün arayınız',
                                            suggestion: Center(
                                              child: Text('İsme göre arama yapınız'),
                                            ),
                                            failure: Center(
                                              child: Text('Ürün bulunamadı'),
                                            ),
                                            filter: (product) => [
                                              product.title,
                                            ],
                                            builder: (product) => ListTile(
                                              title: Text("${product.title}"),
                                              subtitle: Text("₺${product.price}"),
                                              leading: Container(
                                                child: Image.network(
                                                  '${product.image}',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              trailing: Icon(
                                                FontAwesomeIcons.chevronRight,
                                                size: 20,
                                              ),
                                              onTap: (){},
                                            ),
                                          ),
                                        );
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        hintText: 'Ürün ara..',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0)),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Ürün Sayısı', style: TextStyle(color: Colors.white),),
                                        Text('${snapshot.data!.length}', style: TextStyle(color: Colors.white, fontSize: 20))
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                  itemCount: snapshot.data?.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                          return ListTile(
                            title: Text('${snapshot.data?[index].title}'),
                            subtitle: Text('₺${snapshot.data?[index].price}'),
                            leading: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('${snapshot.data?[index].image}'),
                                  fit: BoxFit.fill
                                ),
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50.0)
                              ),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit,color: Colors.amber,),
                                      onPressed: ()async{
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProductsView(product: SampleModel(
                                          id: snapshot.data?[index].id,
                                          type: snapshot.data?[index].type,
                                          title: snapshot.data?[index].title,
                                          subtitle: snapshot.data?[index].subtitle,
                                          image: snapshot.data?[index].image,
                                          price: snapshot.data?[index].price,
                                          gender: snapshot.data?[index].gender,
                                        ))));
                                      }
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete,color: Colors.red,),
                                      onPressed: ()async{
                                        setState(() {
                                          Provider.of<DatabaseService>(context, listen: false).deleteProducts("${snapshot.data![index].id}");
                                        });
                                      }
                                  ),
                                ],
                              ),
                            ),
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

