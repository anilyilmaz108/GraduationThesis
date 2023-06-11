import 'package:flutter_ecommerce/models/sample_model.dart';
import 'package:flutter_ecommerce/models/selected_product_model.dart';

class DataService{
  static List<SelectedProductModel> selectedProductList = [];
  static double totalCost = 0.0;

  static int pastOrders = 0;
  static int favProductNumbers = 0;

  static List<SampleModel> favItem = [];
  static List<SampleModel> filteredList = [];
  static bool isFiltered = false;

  static List<List<String>> productStringArray = [];


}