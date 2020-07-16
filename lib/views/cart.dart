import 'package:aquariusstore/components/main_drawer.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrinho de Compras'),
      ),
      body: LayoutBuilder(
        builder: (ctx, cnt) {
          return ListView.builder(
            itemCount: userController.user.value.cart.length,
            itemBuilder: (ctx, index) {
              Product product = userController.user.value.cart[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.id),
              );
            },
          );
        },
      ),
    );
  }
}
