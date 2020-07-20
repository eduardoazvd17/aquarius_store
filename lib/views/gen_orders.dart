import 'package:aquariusstore/components/cart_badge.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:flutter/material.dart';

class GenOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(child: Text('Gerenciamento de Pedidos')),
        actions: <Widget>[
          CartBadge(
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
