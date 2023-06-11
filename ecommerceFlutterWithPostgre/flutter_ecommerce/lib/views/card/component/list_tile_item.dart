import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/card/card_view.dart';

class ListTileItem extends StatefulWidget {
  String? title;
  String? subtitle;
  String? image;
  double? cost;
  int? itemCount;
  int index;
  ListTileItem({this.title, this.image, this.cost, this.subtitle, this.itemCount, required this.index});
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {

  @override
  Widget build(BuildContext context) {
    DataService.selectedProductList[widget.index].productNumber = widget.itemCount;
    print(widget.itemCount);
    //print(DataService.selectedProductList[0].productNumber);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new ListTile(
        title: new Text("${widget.title}"),
        subtitle: Text("₺${widget.subtitle}"),
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
              color: Color(0xFFF3AE48),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage("${widget.image}"),
                  fit: BoxFit.fill
              )
          ),
        ),
        trailing: Container(
          width: 110,
          child: new Row(
            children: <Widget>[
              widget.itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: (){
                setState((){
                  widget.itemCount = (widget.itemCount! - 1);
                  print(widget.itemCount);
                  //price -= widget.cost!;
                  DataService.totalCost = DataService.totalCost - widget.cost!;

                  print("COST::: ${widget.cost}");
                  //print("PRICE::: $price");
                  print("DATASERVICE PRICE::: ${DataService.totalCost}");
                });

              },):new Container(),
              new Text(widget.itemCount.toString()),
              new IconButton(icon: new Icon(Icons.add),onPressed: (){
                setState((){
                  widget.itemCount = (widget.itemCount! + 1);
                  //price += widget.cost!;
                  DataService.totalCost = DataService.totalCost + widget.cost!;
                  print("COST::: ${widget.cost}");
                  //print("PRICE::: $price");
                  print("DATASERVICE PRICE::: ${DataService.totalCost}");
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}