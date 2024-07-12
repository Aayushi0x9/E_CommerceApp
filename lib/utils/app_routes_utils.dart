import 'package:e_commerce_app/Views/AccountPAge/accountpage.dart';
import 'package:e_commerce_app/Views/AllPages/allpages.dart';
import 'package:e_commerce_app/Views/CartPage/cart_page.dart';
import 'package:e_commerce_app/Views/DetailPage/detail_page.dart';
import 'package:e_commerce_app/Views/HomePage/home_page.dart';
import 'package:e_commerce_app/Views/LikedPage/likedpage.dart';
import 'package:e_commerce_app/Views/LogIn/login_screen.dart';
import 'package:e_commerce_app/Views/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splashScreen = '/';
  static String loginPage = 'loginPage';
  static String allPage = 'allPage';
  static String Homepage = 'homePage';
  static String detailPage = 'detailPage';
  static String cartPage = 'cartPage';
  static String likedPage = 'likedPage';
  static String accountPage = 'accountPage';

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.splashScreen: (context) => SplashScreen(),
    AppRoutes.loginPage: (context) => LoginScreen(),
    AppRoutes.allPage: (context) => AllPages(),
    AppRoutes.Homepage: (context) => HomePage(),
    AppRoutes.detailPage: (context) => DetailPage(),
    AppRoutes.cartPage: (context) => CartPage(),
    AppRoutes.likedPage: (context) => LikedPage(),
    AppRoutes.accountPage: (context) => AccountPage(),
  };

  AppRoutes._();
  static final AppRoutes appRoutes = AppRoutes._();
}
