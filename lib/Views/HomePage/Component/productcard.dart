import 'package:flutter/material.dart';

Widget productCard({required mutable, required index}) {
  return Card(
    child: Column(
      children: [
        Image.network(mutable),
        Text('Product Name'),
        Text('Price'),
      ],
    ),
  );
}
