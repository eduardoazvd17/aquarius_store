import 'package:aquariusstore/views/home.dart';
import 'package:aquariusstore/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aquarius Store',
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        accentColor: Colors.purple[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Routes.HOME: (_) => Home(),
        Routes.SPLASH: (_) => Splash(),
      },
      initialRoute: Routes.SPLASH,
    ),
  );
}
