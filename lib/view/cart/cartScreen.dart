import 'package:ecommerce/resources/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/mobile_modal/orderModal.dart';
import '../../resources/color/color.dart';
import '../../resources/customDrawer/bottumNavigation.dart';
import '../../viewModal/orderController/oredrController.dart';
import '../../viewModal/product_controller/product_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController productController = Get.find<ProductController>();

  void placeOrder() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: productController.cart.toList(),
      total: productController.totalPrice,
      userId: userId,
      createdAt: DateTime.now(),
      status: 'pending',
    );

    final orderController = Get.put(OrderController());
    orderController.placeOrder(newOrder);
    productController.cart.clear(); // Empty cart after placing order

    Get.snackbar("Order Placed", "Your order has been placed successfully!");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: AppColor.wow2,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigation(index: 2),
      body: Obx(() {
        if (productController.cart.isEmpty) {
          return Center(
            child: Text(
              "🛒 Your cart is empty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: productController.cart.length,
                itemBuilder: (_, index) {
                  final item = productController.cart[index];
                  return  Card(
                    color: AppColor.whiteColor,

                    elevation: 19,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.image,
                              width: 130,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(height: 6),
                                Text("Price: \$${item.price.toStringAsFixed(2)}"),
                                Text("Subtotal: \$${(item.price * item.quantity).toStringAsFixed(2)}"),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                      onPressed: () =>
                                          productController.decrementQuantity(item.id),
                                    ),
                                    Text('${item.quantity}',
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline, color: Colors.green),
                                      onPressed: () =>
                                          productController.incrementQuantity(item.id),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.grey),
                                      tooltip: "Remove",
                                      onPressed: () =>
                                          productController.removeFromCart(item.id),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },
              ),
            ),

            // Total + Checkout Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Obx(() => Text(
                        "\$${productController.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColor.wow3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Handle checkout
                        Get.toNamed(RoutesName.payment);
                      },
                      child: Text("Checkout", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
