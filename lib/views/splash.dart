import 'package:aquariusstore/controllers/nav_controller.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/models/user.dart';
import 'package:aquariusstore/services/user_service.dart';
import 'package:aquariusstore/views/nav_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  final NavController navController = Get.put<NavController>(NavController());
  final UserController userController =
      Get.put<UserController>(UserController());
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _isLogged().then((user) {
      widget.userController.setUser(user);
      Future.delayed(Duration(seconds: 1, milliseconds: 500)).then(
        (_) => Get.off(
          NavPage(),
        ),
      );
    });
  }

  Future<User> _isLogged() async {
    return await UserService().loginWithCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Icon(
          Icons.shop,
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.4,
        ),
      ),
    );
  }
}
