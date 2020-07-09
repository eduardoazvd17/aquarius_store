import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextField(
        onChanged: (text) => productController.search(text),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: 'O que está procurando?',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
