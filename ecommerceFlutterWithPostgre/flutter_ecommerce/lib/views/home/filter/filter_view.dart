import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/base_view.dart';
import 'package:flutter_ecommerce/views/home/filter/component/gender_button.dart';
import 'package:flutter_ecommerce/views/home/filter/component/my_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key, required this.product}) : super(key: key);

  final List<SampleModel> product;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  double rangeStart = 0;
  double rangeEnd = 2000;
  RangeValues _currentRangeValues = const RangeValues(0, 2000);
  String filterType = "";
  bool selectedPanth = false;
  bool selectedTshirt = false;
  bool selectedJacket = false;
  bool selectedDress = false;
  String gender = "KADIN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFF2),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),

      ),
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              ListTile(
                  leading: SvgPicture.asset("assets/icons/pants.svg"),
                  title: const Text('Pantolon'),
                  selectedTileColor: Colors.orange,
                  selectedColor: Colors.white,
                  selected: selectedPanth ? true : false,
                  onTap: ()  {
                    setState(() {
                      filterType = "pantolon";
                      selectedPanth = true;
                      selectedDress = false;
                      selectedJacket = false;
                      selectedTshirt = false;
                    });
                  }
              ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/Tshirt.svg"),
                title: const Text('Tshirt'),
                selectedTileColor: Colors.orange,
                selectedColor: Colors.white,
                selected: selectedTshirt ? true : false,
                onTap: ()  {
                  setState(() {
                    filterType = "tshirt";
                    selectedPanth = false;
                    selectedDress = false;
                    selectedJacket = false;
                    selectedTshirt = true;
                  });
                },
              ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/shirt.svg"),
                title: const Text('Ceket'),
                selectedTileColor: Colors.orange,
                selectedColor: Colors.white,
                selected: selectedJacket ? true : false,
                onTap: ()  {
                  setState(() {
                    filterType = "ceket";
                    selectedPanth = false;
                    selectedDress = false;
                    selectedJacket = true;
                    selectedTshirt = false;
                  });
                },
              ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/dress.svg"),
                title: const Text('Elbise'),
                selectedTileColor: Colors.orange,
                selectedColor: Colors.white,
                selected: selectedDress ? true : false,
                onTap: ()  {
                  setState(() {
                    filterType = "elbise";
                    selectedPanth = false;
                    selectedDress = true;
                    selectedJacket = false;
                    selectedTshirt = false;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.black12
                  ),
                  child: Column(
                    children: [
                      Text("Fiyat aralığı $rangeStart₺ - $rangeEnd₺"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RangeSlider(
                          values: _currentRangeValues,
                          min: 0,
                          max: 2000,
                          divisions: 5,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                              rangeStart = _currentRangeValues.start;
                              rangeEnd = _currentRangeValues.end;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyContainer(
                      color: gender == "KADIN"
                          ? Colors.lime
                          : Colors.white,
                      onTap: (){
                        setState(() {
                          gender = "KADIN";
                        });
                      },
                      child: GenderButton(gender: "KADIN", icon: FontAwesomeIcons.venus,),
                    ),
                  ),
                  Expanded(
                    child: MyContainer(
                      color: gender == "ERKEK"
                          ? Colors.lime
                          : Colors.white,
                      onTap: (){
                        setState(() {
                          gender = "ERKEK";
                        });
                      },
                      child: GenderButton(gender: "ERKEK", icon: FontAwesomeIcons.mars,),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        DataService.filteredList.clear();
                        DataService.isFiltered = true;
                        print("$filterType -- $rangeStart -- $rangeEnd -- ${DataService.isFiltered}");
                      });
                      for(int i = 0; i < widget.product.length; i++){
                        if(filterType == widget.product[i].type && widget.product[i].price! > rangeStart && widget.product[i].price! < rangeEnd){
                          DataService.filteredList.add(SampleModel(
                              id: widget.product[i].id,
                              type: widget.product[i].type,
                              title: widget.product[i].title,
                              subtitle: widget.product[i].subtitle,
                              image: widget.product[i].image,
                              price: widget.product[i].price,
                            gender: widget.product[i].gender
                          ));
                        }

                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BaseView(

                        )),
                            (Route<dynamic> route) => false,
                      );
                      /*Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => super.widget));*/
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: const StadiumBorder()),
                    child: const Text("Filtrele", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      setState(() {
                        filterType = "";
                        selectedPanth = false;
                        selectedDress = false;
                        selectedJacket = false;
                        selectedTshirt = false;
                        DataService.isFiltered = false;
                        print("$filterType -- $rangeStart -- $rangeEnd -- ${DataService.isFiltered}");
                      });
                      DataService.filteredList.clear();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BaseView(

                        )),
                            (Route<dynamic> route) => false,
                      );

                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: const StadiumBorder()),
                    child: const Text("Filtreleri Temizle", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
