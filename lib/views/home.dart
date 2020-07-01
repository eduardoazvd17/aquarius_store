import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/components/badge.dart';
import 'package:aquariusstore/components/shop_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
          return Container(
            height: cnt.maxHeight,
            width: cnt.maxWidth,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.05),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: 'O que está procurando?',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.blueGrey,
                    height: 150,
                    width: cnt.maxWidth,
                  ),
                  SizedBox(height: 5),
                  Container(
                    color: Colors.grey,
                    height: 80,
                    width: cnt.maxWidth,
                  ),
                  SizedBox(height: 10),
                  ShopTitle('Populares'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ShopTitle('Mais Vendidos'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 200,
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
