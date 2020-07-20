import 'package:aquariusstore/controllers/user_controller.dart';
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
      body: Obx(
        () => Container(),
      ),
    );
  }
}
