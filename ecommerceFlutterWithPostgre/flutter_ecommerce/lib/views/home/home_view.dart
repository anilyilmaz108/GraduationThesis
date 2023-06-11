import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/category_model.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/detail/detail_view.dart';
import 'package:flutter_ecommerce/views/home/components/category_card.dart';
import 'package:flutter_ecommerce/views/home/components/product_card.dart';
import 'package:flutter_ecommerce/views/home/components/product_item.dart';
import 'package:flutter_ecommerce/views/home/components/section_title.dart';
import 'package:flutter_ecommerce/views/home/filter/filter_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _controller;
  @override

  //List<SampleModel> filteredList = [];
  List<SampleModel> tempAllList = [];

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

  //double rangeStart = 0;
  //double rangeEnd = 2000;
  //RangeValues _currentRangeValues = RangeValues(0, 2000);
  //String filterType = "";
  //bool selectedPanth = false;
  //bool selectedTshirt = false;
  //bool selectedJacket = false;
  //bool selectedDress = false;

  Icon queryIcon = const Icon(
    Icons.query_stats,
  );
  Icon cancelIcon = const Icon(Icons.cancel, color: Colors.orange,);

  Icon customIcon = const Icon(Icons.search, color: Colors.orange,);


  bool seeAll = false;
  String seeAllTitle = "Tümünü Gör";


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child:FutureBuilder<List<SampleModel>>(
              future: Provider.of<DatabaseService>(context,listen: false).getDataProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(height: 8,),
                      FirebaseAuth.instance.currentUser!.isAnonymous ? Align(
                        child: Text('Hoşgeldin, Anonim Kullanıcı', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,),),
                        alignment: Alignment.centerLeft,
                      ) : Align(
                        child: Text('Hoşgeldin, ${FirebaseAuth.instance.currentUser!.displayName}', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,),),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 8,),
                      FirebaseAuth.instance.currentUser!.isAnonymous
                          ? Align(
                        child: Text('Tarzına en uygun ürünleri satın almak için GiysiDolabı ailesine katıl', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),),
                        alignment: Alignment.centerLeft,
                      ) : Align(
                        child: Text('Keşfet, satın al, eğlen...', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 28,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(product: SampleModel(
                                            id: product.id,
                                            type: product.type,
                                            title: product.title,
                                            subtitle: product.subtitle,
                                            image: product.image,
                                            price: product.price,
                                            gender: product.gender
                                          ))));
                                        },
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

                          IconButton(
                            onPressed: ()async{

                              for(int i = 0; i < snapshot.data!.length; i++){
                                  tempAllList.add(SampleModel(
                                      id: snapshot.data![i].id,
                                      type: snapshot.data![i].type,
                                      title: snapshot.data![i].title,
                                      subtitle: snapshot.data![i].subtitle,
                                      image: snapshot.data![i].image,
                                      price: snapshot.data![i].price,
                                    gender: snapshot.data![i].gender
                                  ));


                              }

                              Navigator.push(context, MaterialPageRoute(builder: (context) => FilterView(
                                product: tempAllList,
                              )));
                            },
                            icon: Icon(FontAwesomeIcons.filter, color: Colors.orange,),
                          ),
                        ],
                      ),
                      SizedBox(height: 18,),
                      SizedBox(
                        height: 84,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: demo_categories.length,
                            itemBuilder: (context, index) => CategoryCard(
                              icon: demo_categories[index].icon,
                              title: demo_categories[index].title,
                              press: null,
                            ),
                            separatorBuilder: (context, index) =>
                            const SizedBox(width: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      DataService.isFiltered
                          ? Column(
                            children: [
                              SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: GridView.count(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: (0.7),
                              padding: const EdgeInsets.all(4.0),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: List.generate(
                                DataService.filteredList.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ProductItem(
                                      title: "${DataService.filteredList[index].title}",
                                      image: "${DataService.filteredList[index].image}",
                                      price: DataService.filteredList[index].price,
                                      bgColor: const Color(0xFFFEFBF9),
                                      press: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(product: SampleModel(
                                          id: DataService.filteredList[index].id,
                                          type: DataService.filteredList[index].type,
                                          title: DataService.filteredList[index].title,
                                          subtitle: DataService.filteredList[index].subtitle,
                                          image: DataService.filteredList[index].image,
                                          price: DataService.filteredList[index].price,
                                          gender: DataService.filteredList[index].gender
                                        ))));                                    },
                                    ),
                                  );
                                },
                              ),
                        ),
                      ),
                            ],
                          )
                          : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: SectionTitle(
                              title: "Ürünler",
                              seeAllTitle: seeAllTitle,
                              pressSeeAll: () {
                                seeAll =! seeAll;
                              seeAll ? seeAllTitle = "Daha Az Gör" : seeAllTitle = "Tümünü Gör";
                                setState(() {

                                });

                              },
                            ),
                          ),
                          seeAll
                              ? SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: GridView.count(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: (0.7),
                              padding: const EdgeInsets.all(4.0),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: List.generate(
                                snapshot.data!.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ProductItem(
                                      title: "${snapshot.data![index].title}",
                                      image: "${snapshot.data![index].image}",
                                      price: snapshot.data![index].price,
                                      bgColor: const Color(0xFFFEFBF9),
                                      press: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(product: SampleModel(
                                          id: snapshot.data![index].id,
                                          type: snapshot.data![index].type,
                                          title: snapshot.data![index].title,
                                          subtitle: snapshot.data![index].subtitle,
                                          image: snapshot.data![index].image,
                                          price: snapshot.data![index].price,
                                          gender: snapshot.data![index].gender
                                        ))));                                    },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                              : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                4,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: ProductCard(
                                      title: "${snapshot.data![index].title}",
                                      image: "${snapshot.data![index].image}",
                                      price: snapshot.data![index].price,
                                      bgColor: const Color(0xFFFEFBF9),
                                      press: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(product: SampleModel(
                                          id: snapshot.data![index].id,
                                          type: snapshot.data![index].type,
                                          title: snapshot.data![index].title,
                                          subtitle: snapshot.data![index].subtitle,
                                          image: snapshot.data![index].image,
                                          price: snapshot.data![index].price,
                                          gender: snapshot.data![index].gender
                                        ))));
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ),
        )


      ),
    );
  }
}


