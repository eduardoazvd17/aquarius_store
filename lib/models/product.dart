import 'dart:convert';

import 'dart:math';

class Product {
  String id;
  String name;
  String description;
  double price;
  List<String> imagesUrl = [];
  String mainImageUrl;

  Product({this.name, this.description, this.price});

  setMainImage(String url) => this.mainImageUrl = url;

  generateId() {
    this.id = this.name + Random().nextInt(999999999).toString();
  }

  removeImage(String url) {
    if (mainImageUrl == url) {
      mainImageUrl = null;
    }
    this.imagesUrl.remove(url);
  }

  addImage(String url) => this.imagesUrl.add(url);

  addImageUrl(String url) {
    this.imagesUrl.add(url);
  }

  removeImageUrl(int index) {
    this.imagesUrl.removeAt(index);
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
