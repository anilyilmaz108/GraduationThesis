import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/services/image_service.dart';
import 'package:flutter_ecommerce/views/admin/CRUD_view.dart';
import 'package:flutter_ecommerce/views/admin/purchased_view.dart';
import 'package:flutter_ecommerce/views/beginning.dart';
import 'package:provider/provider.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  late TextEditingController _genderController;



  void initState() {
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
    _priceController = TextEditingController();
    _imageController = TextEditingController();
    _genderController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
    _priceController = TextEditingController();
    _imageController = TextEditingController();
    _genderController = TextEditingController();
    super.dispose();
  }

  String dropdownValue = "Pantolon";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Administrator"),
        centerTitle: true,
        leading: Container(),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Ürün Ekle",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: TextField(
                  controller: _imageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.image),
                    hintText: "Ürün resmi",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: TextField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    hintText: "Ürün adı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: TextField(
                  controller: _subtitleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.subtitles),
                    hintText: "Ürün açıklaması",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    hintText: "Ürün fiyatı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: TextField(
                  controller: _genderController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Cinsiyet",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>["Pantolon", "Ceket", "Tshirt", "Elbise" ]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height:40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                  ),
                  onPressed: ()  {
                    //Provider.of<DatabaseService>(context,listen: false).initDatabaseConnection(_titleController.text, _subtitleController.text, dropdownValue, _imageController.text, double.parse(_priceController.text));
                    Provider.of<DatabaseService>(context,listen: false).postProduct(_titleController.text, _subtitleController.text, dropdownValue, _imageController.text, double.parse(_priceController.text), _genderController.text);

                    final snackBar = SnackBar(
                      content: Text('${_titleController.text} eklendi'),
                      backgroundColor: Colors.orange,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  },
                  child: Text("Ekle"),
                ),
              ),
              SizedBox(
                height:20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                  ),
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CRUDView()));
                  },
                  child: Text("CRUD"),
                ),
              ),
              SizedBox(
                height:20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                  ),
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasedView()));
                  },
                  child: Text("Satış Takip"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


