import 'package:e_commerce_app/Views/AccountPAge/accountpage.dart';
import 'package:e_commerce_app/Views/CartPage/cart_page.dart';
import 'package:e_commerce_app/Views/HomePage/home_page.dart';
import 'package:e_commerce_app/Views/LikedPage/likedpage.dart';
import 'package:flutter/material.dart';

class AllPages extends StatefulWidget {
  const AllPages({super.key});

  @override
  State<AllPages> createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPages> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    LikedPage(),
    CartPage(),
    AccountPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'User',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black54,
        onTap: onItemTapped,
      ),
    );
  }
}
