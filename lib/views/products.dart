import 'package:aquariusstore/components/badge.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aquarius Store'),
        actions: <Widget>[
          Badge(
            value: '0',
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: LayoutBuilder(
        builder: (ctx, cnt) {
          return Container();
        },
      ),
    );
  }
}
