import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/user_service.dart';
import 'package:get/get.dart';
import 'package:aquariusstore/models/user.dart';

class UserController extends GetxController {
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
      user.value.cart.add(p);
      Get.snackbar(
        'Adicionado ao Carrinho',
        'O produto ${p.name} foi adicionado ao carrinho de compras',
        duration: Duration(seconds: 1),
      );
    }
  }

  void removeToCart(Product p) =>
      user.value.cart.removeWhere((item) => item.id == p.id);
}
