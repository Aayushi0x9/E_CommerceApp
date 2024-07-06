import 'package:e_commerce_app/Views/HomePage/home_page.dart';
import 'package:flutter/material.dart';

import 'CartPage/cart_page.dart';
import 'DetailPage/detail_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue.shade50),
      routes: {
        '/': (context) => HomePage(),
        'detail_page': (context) => DetailPage(),
        'cart_page': (context) => CartPage(),
      },
    );
  }
}
