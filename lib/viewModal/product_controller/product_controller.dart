import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../modal/mobile_modal/mobil_modal.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var products = <MobileModel>[].obs;
  var favorites = <String>{}.obs;
  var cart = <MobileModel>[].obs;



  @override
  void onInit() {
    super.onInit();
    loadProducts(); // Load all products at startup
  }

  Future<void> loadProducts() async {
    final snapshot = await _firestore.collection('products').get();
    products.value =
        snapshot.docs.map((doc) => MobileModel.fromJson(doc.data())).toList();
  }

  Future<List<MobileModel>> getProductsByCategory(String category) async {
    final snapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs.map((doc) => MobileModel.fromJson(doc.data())).toList();
  }
  Future<void> uploadCategoriesToFirestore() async {
    final categories = [
      {'name': 'Samsung', 'image': 'assets/images/samsung1.png'},
      {'name': 'iPhone', 'image': 'assets/images/iphone.png'},
      {'name': 'Vivo', 'image': 'assets/images/vivo.jpg'},
      {'name': 'Infinix', 'image': 'assets/images/infinixhot10.jpg'},
      {'name': 'RedMe', 'image': 'assets/images/RedMe.png'},
      {'name': 'Oppo', 'image': 'assets/images/opoo.jpg'},
    ];

    final collection = FirebaseFirestore.instance.collection('categories');
    for (final category in categories) {
      await collection.doc(category['name']).set(category);
    }

    print('✅ Categories uploaded');
  }

  // Optional one-time upload
  Future<void> uploadProductsToFirestore(List<MobileModel> mobileList) async {
    final collection = _firestore.collection('products');
    for (final product in mobileList) {
      await collection.doc(product.id).set(product.toJson());
    }
  }

  // Cart/Favorites logic...
  void toggleFavorite(String productId) {
    favorites.contains(productId) ? favorites.remove(productId) : favorites.add(productId);
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

  void removeFromCart(String productId) {
    cart.removeWhere((item) => item.id == productId);
    cart.refresh();
    Get.snackbar("Cart", "Item removed from cart");
  }

  void incrementQuantity(String productId) {
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cart[index].quantity += 1;
      cart.refresh();
    }
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
    products.removeWhere((p) => p.id == productId);
    products.refresh();
    Get.snackbar("Deleted", "Product has been deleted");
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
