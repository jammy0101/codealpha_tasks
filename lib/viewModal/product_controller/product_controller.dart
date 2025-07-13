import 'package:get/get.dart';
import '../../modal/mobile_modal/mobil_modal.dart';
import '../../modal/mobile_modal/mobile_modalList.dart';


class ProductController extends GetxController {

  var products = <MobileModel>[].obs;
  var favorites = <String>{}.obs;
  var cart = <MobileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    products.assignAll(fetchProducts()); // ✅ Assign static list on start
  }

  List<MobileModel> fetchProducts() {
    return mobileList; // ✅ From your static list
  }

  void toggleFavorite(String productId) {
    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }
  }

  void removeFromCart(String productId) {
    cart.removeWhere((item) => item.id == productId);
    cart.refresh();
    Get.snackbar("Cart", "Item removed from cart");
  }



  void addToCart(MobileModel product) {
    final index = cart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cart[index].quantity += 1;
    } else {
      cart.add(product.copyWith(quantity: 1));
    }
    cart.refresh();
    Get.snackbar("Cart", "${product.name} added to cart");
  }

  void incrementQuantity(String productId) {
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cart[index].quantity += 1;
      cart.refresh();
    }
  }

  void decrementQuantity(String productId) {
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      if (cart[index].quantity > 1) {
        cart[index].quantity -= 1;
      } else {
        cart.removeAt(index);
      }
      cart.refresh();
    }
  }

  int get cartItemCount => cart.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => cart.fold(0.0, (sum, item) => sum + item.price * item.quantity);
}


