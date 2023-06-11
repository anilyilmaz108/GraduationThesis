import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/favourite_model.dart';
import 'package:flutter_ecommerce/models/purchased_model.dart';
import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/models/selected_product_model.dart';
import 'package:http/http.dart';
import 'package:postgres/postgres.dart';
import 'package:http/http.dart' as http;

class DatabaseService extends ChangeNotifier{
  var connection = PostgreSQLConnection("10.0.2.2", 5432, "ecommercedb", username: "postgres", password: "176369",);

 initDatabaseConnection(String title, String subtitle, String type, String image, double price) async {
    if(connection.isClosed){
      await connection.open().then((value) {
        debugPrint("Database Connected!");
      });
    }

    final data = <String, dynamic>{
      "title": title,
      "subtitle": subtitle,
      "type": type,
      "price": price,
      "image": image,
    };
    await setData(connection, "products", data);
    debugPrint('İŞLEM BİTTİ');
    //await connection.close();


  }
  Future<void> setData(PostgreSQLConnection connection, String table,
      Map<String, dynamic> data) async {
    await connection.execute(
        'INSERT INTO $table (${data.keys.join(', ')}) VALUES (${data.keys.map((k) => '@$k').join(', ')})',
        substitutionValues: data);
    await connection.close();
  }


  Future<List<SampleModel>> getDataProducts() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return SampleModel.fromJson(jsonDecode(response.body));


      return [
        for (final item in jsonDecode(response.body)) SampleModel.fromJson(item),
      ];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<FavouriteModel>> getDataFavourites() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/favourites'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return SampleModel.fromJson(jsonDecode(response.body));


      return [
        for (final item in jsonDecode(response.body)) FavouriteModel.fromJson(item),
      ];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> deleteFavourites(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:4000/favourites/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  Future<http.Response> deleteProducts(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:4000/products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  initDatabaseConnectionUpdate(String id, String title, String subtitle, String image, String price, String type) async {
    if(connection.isClosed){
      await connection.open().then((value)async {
        debugPrint("Database Connected!");
        await connection.query("UPDATE products SET title='$title', subtitle='$subtitle', image='$image', price='$price', type='$type' WHERE id=$id");
        await connection.close();
      });
    }


  }

  Future<FavouriteModel> postFav(String userid, String favid) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:4000/favourites'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userid,
        'fav_id': favid
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return FavouriteModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<http.Response> postProduct(String title, String subtitle, String type, String image, double price, String gender) {
    return http.post(
      Uri.parse('http://10.0.2.2:4000/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'price': price.toString(),
        'type': type,
        'gender': gender
      }),
    );
  }

  Future<http.Response> updateProduct(String id, String title, String subtitle, String type, String image, double price, String gender) {
    return http.put(
      Uri.parse('http://10.0.2.2:4000/products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'price': price.toString(),
        'type': type,
        'gender': gender
      }),
    );
  }

  Future<http.Response> postPurchased(DateTime date, String user, double amount, String address, List<List<String>> products) {
    return http.post(
      Uri.parse('http://10.0.2.2:4000/purchased'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'date': date.toString(),
        'customer': user,
        'amount': amount.toString(),
        'address': address,
        'products': products,
      }),
    );
  }

  Future<List<PurchasedModel>> getDataPurchased() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/purchased'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return SampleModel.fromJson(jsonDecode(response.body));


      return [
        for (final item in jsonDecode(response.body)) PurchasedModel.fromJson(item),
      ];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }


}