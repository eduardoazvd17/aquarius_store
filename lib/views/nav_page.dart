import 'package:aquariusstore/controllers/nav_controller.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/views/cart.dart';
import 'package:aquariusstore/views/gen_highlights.dart';
import 'package:aquariusstore/views/gen_orders.dart';
import 'package:aquariusstore/views/gen_products.dart';
import 'package:aquariusstore/views/gen_users.dart';
import 'package:aquariusstore/views/orders.dart';
import 'package:aquariusstore/views/products.dart';
import 'package:aquariusstore/views/shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class NavPage extends StatelessWidget {
  final NavController navController = Get.find<NavController>();
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageView(
        controller: navController.pageController.value,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
          Products(),
          Orders(),
          Shops(),
          GenHighlights(),
          GenUsers(),
          GenProducts(),
          GenOrders(),
          Cart(),
        ],
      ),
    );
  }
}
