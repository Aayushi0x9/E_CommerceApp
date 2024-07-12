import 'dart:convert';

import 'package:e_commerce_app/Models/product_model.dart';
import 'package:e_commerce_app/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ProductHelper {
  ProductHelper._();
  static ProductHelper productHelper = ProductHelper._();
  String productsApi = 'https://dummyjson.com/products?limit=100';
  Future<List<Product>> getAllProduct() async {
    List<Product> allProduct = [];
    http.Response response = await http.get(Uri.parse(productsApi));
    Logger().i(response.statusCode);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      Logger().i(Globals.globals.SearchData);
      List allData = data["products"];
      allProduct = allData.map((e) => Product.fromJson(e)).toList();
    }
    Logger().i(allProduct);
    return allProduct;
  }
}
