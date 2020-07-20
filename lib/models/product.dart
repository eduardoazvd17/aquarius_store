import 'dart:convert';

import 'dart:math';

class Product {
  //ID gerado automaticamente ao enviar novo produto ao firebase.
  String id;
  String name;
  String description;
  double price;
  List<String> imagesUrl;
  String mainImageUrl;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imagesUrl,
    this.mainImageUrl,
  });

  addImageUrl(String url) {
    this.imagesUrl.add(url);
  }

  removeImageUrl(int index) {
    this.imagesUrl.removeAt(index);
  }

  String generateId() {
    var randomCode = Random().nextInt(999999);
    while (randomCode < 100000) {
      randomCode *= 10;
    }
    this.id = name.replaceAll(' ', '') + randomCode.toString();
    return id;
  }

  String toJson() {
    Map<String, dynamic> productMap = {};
    productMap.putIfAbsent('id', () => id);
    productMap.putIfAbsent('name', () => name);
    productMap.putIfAbsent('description', () => description);
    productMap.putIfAbsent('price', () => price.toStringAsFixed(2));
    productMap.putIfAbsent('imagesUrl', () => imagesUrl);
    productMap.putIfAbsent('mainImageUrl', () => mainImageUrl);
    return json.encode(productMap);
  }

  Product.fromJson(String productJSON) {
    Map<String, dynamic> productMap = json.decode(productJSON);
    this.id = productMap['id'];
    this.name = productMap['name'];
    this.description = productMap['description'];
    this.price = double.tryParse(productMap['price']);
    this.imagesUrl =
        List<String>.from(productMap['imagesUrl'] as List<dynamic>);
    this.mainImageUrl = productMap['mainImageUrl'];
  }
}
