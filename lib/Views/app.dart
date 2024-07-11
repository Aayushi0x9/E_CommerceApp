import 'package:e_commerce_app/utils/app_routes_utils.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue.shade50),
      initialRoute: AppRoutes.Homepage,
      routes: AppRoutes.routes,
    );
  }
}
