import 'package:aquariusstore/services/user_service.dart';
import 'package:get/get.dart';
import 'package:aquariusstore/models/user.dart';

class UserController extends GetxController {
  Rx<User> user;
  void setUser(User newUser) {
    if (newUser == null) {
      user = null;
      UserService().deleteCredentials();
    } else {
      user = newUser.obs;
    }
  }
}
