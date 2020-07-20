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
}
