import 'package:get/get.dart';

import '../../modal/productModel/product_Model.dart';
import '../../modal/product_services/product_services.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var favorites = <String>{}.obs;
  var cart = <Product>[].obs;
  final RxBool showCartBadge = false.obs;
  final ProductService _service = ProductService();

  @override
  void onInit() {
    products.value = _service.fetchProducts();
    super.onInit();
  }

  void toggleFavorite(String productId) {
    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
      triggerCartBadge();
    }
  }

  void triggerCartBadge() {
    showCartBadge.value = true;
    Future.delayed(Duration(seconds: 2), () {
      showCartBadge.value = false;
    });
  }
  void addToCart(Product product) {
    cart.add(product);
    Get.snackbar("Cart", "${product.name} added to cart");
  }
}