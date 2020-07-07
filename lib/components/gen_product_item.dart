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
      leading: CircleAvatar(
        child: Image.network(
          product.imagesUrl[0],
          fit: BoxFit.cover,
        ),
      ),
      title: Text(product.name),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(product.price.toStringAsFixed(2)),
          SizedBox(height: 5),
          Text(product.description)
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {},
      ),
    );
  }
}
