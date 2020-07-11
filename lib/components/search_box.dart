import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final productController = Get.find<ProductController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.clear();
    searchController
        .addListener(() => productController.search(searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: 'O que está procurando?',
          suffixIcon: IconButton(
            icon: searchController.text.isEmpty
                ? Icon(Icons.search)
                : Icon(Icons.close),
            onPressed: () {
              searchController.clear();
            },
          ),
        ),
      ),
    );
  }
}
