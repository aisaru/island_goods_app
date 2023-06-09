import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/account_screen.dart';
import 'package:island_goods/views/buyers/nav_screens/cart_screen.dart';
import 'package:island_goods/views/buyers/nav_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _nameState();
}

class _nameState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    Homescreen(),
    CartScreen(
      cartItems: [],
    ),
    Accountscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            // BottomNavigationBarItem(
            //   // icon: SvgPicture.asset(
            //   //   'assets/icons/explore.svg',
            //   //   width: 20,
            //   icon: Icon(Icons.category_outlined),
            //   label: 'CATEGORIES',
            // ),
            // BottomNavigationBarItem(
            //   // icon: SvgPicture.asset(
            //   //   'assets/icons/shop.svg',
            //   //   width: 20,
            //   // ),
            //   icon: Icon(Icons.storefront_outlined),
            //   label: 'STORE',
            // ),
            BottomNavigationBarItem(
              // icon: SvgPicture.asset(
              //   'assets/icons/cart.svg',
              // ),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'CART',
            ),
            // BottomNavigationBarItem(
            //   // icon: SvgPicture.asset(
            //   //   'assets/icons/search.svg',
            //   // ),
            //   icon: Icon(Icons.search),
            //   label: 'SEARCH',
            // ),
            BottomNavigationBarItem(
              // icon: SvgPicture.asset(
              //   'assets/icons/account.svg',
              // ),
              icon: Icon(Icons.person),
              label: 'ACCOUNT',
            ),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
