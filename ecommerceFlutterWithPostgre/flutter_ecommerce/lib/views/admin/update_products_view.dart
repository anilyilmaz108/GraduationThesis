import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/views/admin/CRUD_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdateProductsView extends StatefulWidget {
  UpdateProductsView({Key? key, required this.product}) : super(key: key);
  SampleModel product;

  @override
  State<UpdateProductsView> createState() => _UpdateProductsViewState();
}

class _UpdateProductsViewState extends State<UpdateProductsView> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  late TextEditingController _typeController;
  late TextEditingController _genderController;



  void initState() {
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
    _priceController = TextEditingController();
    _imageController = TextEditingController();
    _typeController = TextEditingController();
    _genderController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
    _priceController = TextEditingController();
    _imageController = TextEditingController();
    _typeController = TextEditingController();
    _genderController = TextEditingController();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //String dropdownValue = "${widget.product.type}";
    return Scaffold(
      appBar: AppBar(
        title: Text("Update ${widget.product.title}"),
        centerTitle: true,
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
                "Ürün Güncelle",
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
                    labelText: "${widget.product.image}",
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
                    labelText: "${widget.product.title}",
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
                    labelText: "${widget.product.subtitle}",
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
                    labelText: "${widget.product.price}",
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
                  controller: _typeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.dry_cleaning),
                    labelText: "${widget.product.type}",
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
                    labelText: "${widget.product.gender}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
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
                    Provider.of<DatabaseService>(context,listen: false).updateProduct(widget.product.id.toString(),_titleController.text,_subtitleController.text,_typeController.text,_imageController.text,double.parse(_priceController.text), _genderController.text);
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => CRUDView()));
                    final snackBar = SnackBar(
                      content: Text('${_titleController.text} güncellendi'),
                      backgroundColor: Colors.orange,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text("Güncelle"),
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
                    Navigator.pop(context);
                  },
                  child: Text("İptal"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

