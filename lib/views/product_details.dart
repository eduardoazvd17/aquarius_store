import 'package:aquariusstore/components/no_image.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final Product product;
  ProductDetails(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name),
      ),
      body: LayoutBuilder(
        builder: (ctx, cnt) {
          return Container(
            width: double.infinity,
            height: 300,
            child: Hero(
              transitionOnUserGestures: true,
              tag: product.id,
              child: FittedBox(
                fit: BoxFit.cover,
                child: product.mainImageUrl == null
                    ? NoImage()
                    : Image.network(
                        '${product.mainImageUrl}',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
