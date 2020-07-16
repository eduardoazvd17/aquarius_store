import 'package:aquariusstore/components/badge.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aquarius Store'),
        actions: <Widget>[
          Obx(
            () => Badge(
              value: userController.user.value == null
                  ? '0'
                  : userController.user.value.cart.length.toString(),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
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
