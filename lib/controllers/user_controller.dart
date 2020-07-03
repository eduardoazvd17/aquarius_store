import 'package:get/get.dart';
import 'package:aquariusstore/models/user.dart';

class UserController extends GetxController {
  Rx<User> user;

  setUser(User newUser) {
    if (newUser == null) {
      user = null;
    } else {
      user = newUser.obs;
    }
  }
}
