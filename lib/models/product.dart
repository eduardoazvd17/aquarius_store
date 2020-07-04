import 'dart:convert';

class Product {
  //ID gerado automaticamente ao enviar novo produto ao firebase.
  String id;
  String name;
  String description;
  double price;
  List<String> imagesUrl = [];

  Product({
    this.name,
    this.description,
    this.price,
  });

  addImageUrl(String url) {
    this.imagesUrl.add(url);
  }

  removeImageUrl(int index) {
    this.imagesUrl.removeAt(index);
  }

  String toJson() {
    Map<String, dynamic> productMap = {};
    productMap.putIfAbsent('name', () => name);
    productMap.putIfAbsent('description', () => description);
    productMap.putIfAbsent('price', () => price.toStringAsFixed(2));
    productMap.putIfAbsent('imagesUrl', () => imagesUrl);
    return json.encode(productMap);
  }

  Product.fromJson(String productJSON) {
    Map<String, dynamic> productMap = json.decode(productJSON);
    this.name = productMap['name'];
    this.description = productMap['description'];
    this.price = double.tryParse(productMap['price']);
    this.imagesUrl = productMap['imagesUrl'];
  }
}
