import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<Product> allProducts = RxList([]);
  RxList<Product> products = RxList([]);

  init() async {
    var pService = ProductService();
    List<Product> loadedProducts = await pService.loadAllProducts();
    allProducts.value = loadedProducts;
    products.value = loadedProducts;
  }

  search(String textFilter) {
    if (textFilter == null || textFilter.isEmpty) {
      products.value = allProducts.value;
    } else {
      products.value = allProducts.value
          .where((p) => p.name.toLowerCase().contains(textFilter.toLowerCase()))
          .toList();
    }
  }

  add(Product p) {
    allProducts.value.add(p);
    products.value = allProducts.value;
  }

  remove(Product p) {
    allProducts.remove(p);
    products.value = allProducts.value;
  }
}
