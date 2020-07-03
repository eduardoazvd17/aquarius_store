import 'package:aquariusstore/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;
  DrawerTile({this.iconData, this.title, this.page});
  final NavController navController = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navController.setPage(page),
      child: SizedBox(
        height: 60,
        child: Obx(
          () => Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Icon(
                  iconData,
                  size: 32,
                  color: navController.pageController.value.page == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: navController.pageController.value.page == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
