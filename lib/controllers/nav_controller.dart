import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var pageController = PageController().obs;
  void setPage(int value) => pageController.value.jumpToPage(value);
}
