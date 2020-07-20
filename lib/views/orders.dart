import 'package:aquariusstore/components/cart_badge.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/views/cart.dart';
import 'package:aquariusstore/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orders extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aquarius Store'),
        actions: <Widget>[
          CartBadge(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  !userController.isLogged() ? Get.to(Login()) : Get.to(Cart()),
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
