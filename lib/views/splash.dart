import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/routes.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (value) => Get.toNamed(
        Routes.HOME,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.shop,
          size: MediaQuery.of(context).size.width * 0.25,
        ),
      ),
    );
  }
}
