import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<Product> allProducts = RxList([]);
  RxList<Product> products = RxList([]);

  ProductController() {
    var pService = ProductService();
    pService.loadAllProducts().then((list) => allProducts.value = list);
  }

  List<Product> search(String textFilter) {
    if (textFilter == null || textFilter.isEmpty) {
      products.value = allProducts.value;
    } else {
      products.value =
          allProducts.value.where((p) => p.name.contains(textFilter)).toList();
    }
  }
}
