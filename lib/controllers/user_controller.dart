import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aquariusstore/models/user.dart';

class UserController extends GetxController {
  final UserService _service = UserService();
  Rx<User> user = Rx();

  void setUser(User newUser) {
    if (newUser == null) {
      user.value = null;
      UserService().deleteCredentials();
    } else {
      user.value = newUser;
    }
  }

  bool isLogged() => user.value != null;

  void addToCart(Product p) {
    List tempItems = user.value.cart.where((temp) => p.id == temp.id).toList();
    if (tempItems.length == 0) {
      user.update((user) => user.cart.add(p));
      Get.snackbar(
        'Adicionado ao carrinho',
        'O produto ${p.name} foi adicionado ao carrinho de compras',
        snackPosition: SnackPosition.BOTTOM,
      );
      _service.updateUser(user.value);
    } else {
      Get.snackbar(
        'Produto já adicionado',
        'O produto ${p.name} já está no carrinho de compras',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromCart(Product p) {
    Get.dialog(AlertDialog(
      title: Text('Remover do carrinho'),
      content: Text(
          'Deseja realmente remover o produto ${p.name} do carrinho de compras?'),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              user.update(
                  (user) => user.cart.removeWhere((item) => item.id == p.id));
              _service.updateUser(user.value);
              Get.close(1);
            },
            textColor: Colors.purple[300],
            child: Text('Sim')),
        FlatButton(
            onPressed: () => Get.close(1),
            textColor: Colors.purple[300],
            child: Text('Não')),
      ],
    ));
  }
}
