import 'package:aquariusstore/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  var _db = Firestore.instance.collection('products');

  Future<bool> addProduct(Product product) async {
    try {
      await _db.document().setData({
        'data': product.toJson(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await _db.document(product.id).updateData({
        'data': product.toJson(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeProduct(Product product) async {
    try {
      await _db.document(product.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Product>> loadAllProducts() async {
    List<Product> products = [];
    final QuerySnapshot querySnapshot = await _db.getDocuments();
    for (var doc in querySnapshot.documents) {
      Product p = Product.fromJson(doc.data['data']);
      //Atribuindo id automático do firebase ao modelo.
      p.id = doc.documentID;
      products.add(p);
    }
    return products;
  }
}
