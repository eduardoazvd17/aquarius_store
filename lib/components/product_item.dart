import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: Open product details.
      },
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
              //TODO: Add to cart.
            },
          ),
        ),
      ),
    );
  }
}
