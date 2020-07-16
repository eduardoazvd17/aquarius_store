import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/components/gen_product_item.dart';
import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/components/search_box.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/views/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenProducts extends StatelessWidget {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(child: Text('Gerenciamento de Produtos')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(
              AddProduct(),
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
                        ? EmptyListMessage('Nenhum produto cadastrado')
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 70, left: 10, right: 10),
                            child: Obx(
                              () => ListView.builder(
                                itemCount:
                                    productController.products.value.length,
                                itemBuilder: (ctx, index) {
                                  return GenProductItem(
                                      productController.products[index]);
                                },
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
