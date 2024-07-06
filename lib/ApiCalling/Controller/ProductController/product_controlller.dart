import 'package:e_commerce_app/ApiCalling/Services/product_helper.dart';
import 'package:e_commerce_app/Models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductController extends ChangeNotifier {
  List<Product> allProducts = [];
  List<Product> cartProducts = [];

  ProductController() {
    loadAllProductData();
  }

  Future<void> loadAllProductData() async {
    allProducts = await ProductHelper.productHelper.getAllProduct();
    notifyListeners();
  }

  List images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJu-wARWxJPP6NyREm3pRppKZa4OK_8GpU5A&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsPyXZCEvJswYPVJxUGMZtqCG3p9CmXdKFTw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2yuP0EzytrU3MjckGMoPtZizhaa3uV-TGjQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK94PulbRH6ipuzZYHbJNxpW1Z-Ve6Jyt5_g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKh5kjIjVlo633wUrOKhsxdfi19OAWb6kuGg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_WMPD3D5e37KA5PXMUOR5zHdKhpFYQYA1qA&s',
  ];
}
