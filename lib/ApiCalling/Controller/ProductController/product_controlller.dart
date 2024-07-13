import 'package:e_commerce_app/ApiCalling/Services/product_helper.dart';
import 'package:e_commerce_app/Models/product_model.dart';
import 'package:e_commerce_app/Views/AccountPAge/accountpage.dart';
import 'package:e_commerce_app/Views/CartPage/cart_page.dart';
import 'package:e_commerce_app/Views/HomePage/home_page.dart';
import 'package:e_commerce_app/Views/LikedPage/likedpage.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  List<Product> allProducts = [];
  List<Product> cartProducts = [];

  List<Product> likedProducts = [];
  double discount = 0.0;
  double totalPrice = 0.0;
  double subtotalPrice = 0.0;

  ProductController() {
    loadAllProductData();
  }

  Future<void> loadAllProductData() async {
    allProducts = await ProductHelper.productHelper.getAllProduct();
    notifyListeners();
  }

  double totalProductPrice() {
    totalPrice = 0.0;
    cartProducts.forEach((element) {
      discount = (element.price * (element.discountPercentage ?? 0.0)) / 100;
      totalPrice += (element.price - discount) * element.qty;
    });
    return totalPrice;
  }

  double allProductPrice() {
    subtotalPrice = 0.0;
    cartProducts.forEach((element) {
      subtotalPrice += (element.price * element.qty);
    });
    return subtotalPrice;
  }

  double totalDiscount() {
    discount = 0.0;
    cartProducts.forEach((element) {
      discount += (element.qty *
          (element.price * (element.discountPercentage ?? 0.0)) /
          100);
    });
    return discount;
  }

  void notify() {
    notifyListeners();
  }

  void onItemTapped(
      {required index,
      required BuildContext context,
      required dynamic selectedIndex}) {
    selectedIndex = index;
    notifyListeners();
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LikedPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
        break;
    }
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
