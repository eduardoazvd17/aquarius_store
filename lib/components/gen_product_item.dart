import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';

class GenProductItem extends StatelessWidget {
  final Product product;
  GenProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      isThreeLine: true,
      leading: FittedBox(
        child: Image.network(
          product.imagesUrl[0],
          fit: BoxFit.cover,
        ),
      ),
      title: Text(product.name),
      subtitle: Text(product.price.toStringAsFixed(2)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
