import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/views/login.dart';
import 'package:aquariusstore/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final UserController userController = Get.find<UserController>();
  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ProductDetails(product)),
      child: GridTile(
        child: Image.network(
          '${product.mainImageUrl}',
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          subtitle: Text('R\$${product.price.toStringAsFixed(2)}'),
          title: FittedBox(
            child: Text(
              '${product.name}',
              textAlign: TextAlign.left,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (!userController.isLogged()) {
                Get.to(Login());
              } else {
                userController.user.value.cart.add(product);
              }
            },
          ),
        ),
      ),
    );
  }
}
