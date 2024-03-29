import 'package:aquariusstore/components/cart_badge.dart';
import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/components/product_item.dart';
import 'package:aquariusstore/components/search_box.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/views/cart.dart';
import 'package:aquariusstore/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final productController = Get.find<ProductController>();
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
          return Stack(
            children: <Widget>[
              SearchBox(),
              Obx(
                () => productController.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : productController.products.value.length == 0
                        ? EmptyListMessage('Nenhum produto encontrado :/')
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 70, left: 10, right: 10),
                            child: Obx(
                              () => GridView.builder(
                                itemCount:
                                    productController.products.value.length,
                                itemBuilder: (ctx, index) {
                                  return ProductItem(
                                      productController.products[index]);
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                              ),
                            ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
