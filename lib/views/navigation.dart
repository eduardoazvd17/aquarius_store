import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/views/nav_favorites.dart';
import 'package:aquariusstore/views/nav_home.dart';
import 'package:aquariusstore/views/nav_shop.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _pageIndex = 0;

  _changePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final List<Widget> pages = [
    NavHome(),
    NavShop(),
    NavFavorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          _pageIndex == 0 ? 'Início' : _pageIndex == 1 ? 'Loja' : 'Favoritos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      drawer: MainDrawer(
        changePage: _changePage,
        pageIndex: _pageIndex,
      ),
      body: pages[_pageIndex],
    );
  }
}
