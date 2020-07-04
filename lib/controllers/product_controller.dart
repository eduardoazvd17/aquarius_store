import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductController() {
    var pService = ProductService();
    pService.loadAllProducts().then((list) => allProducts.value = list);
  }
  RxList<Product> allProducts;

  List<Product> filterProducts(String textFilter) {
    if (allProducts == null || allProducts.value == null) {
      return [];
    } else {
      return allProducts.value
          .where((p) => p.name.contains(textFilter))
          .toList();
    }
  }
}
