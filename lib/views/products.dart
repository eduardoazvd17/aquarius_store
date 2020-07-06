import 'package:aquariusstore/components/badge.dart';
import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/components/product_item.dart';
import 'package:aquariusstore/components/search_box.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatelessWidget {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aquarius Store'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
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
          return Stack(
            children: <Widget>[
              SearchBox(),
              productController.allProducts.value.length == 0
                  ? EmptyListMessage('Nenhum produto encontrado :/')
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 70, left: 10, right: 10),
                      child: GridView.builder(
                        itemCount: productController.products.value.length,
                        itemBuilder: (ctx, index) {
                          return ProductItem(productController.products[index]);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
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
