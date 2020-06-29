import 'package:aquariusstore/views/home.dart';
import 'package:aquariusstore/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'utils/routes.dart';

void main() async {
  await GetStorage.init();
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
        Routes.SPLASH: (_) => Splash(),
        Routes.HOME: (_) => Home(),
      },
      initialRoute: Routes.SPLASH,
    ),
  );
}
