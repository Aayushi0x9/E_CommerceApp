import 'package:e_commerce_app/ApiCalling/Controller/ProductController/product_controlller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Views/app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductController()),
    ],
    child: MyApp(),
  ));
}
