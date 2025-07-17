import 'package:ecommerce/resources/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/addProduct/addProductScreen.dart';
import '../../viewModal/product_controller/product_controller.dart';

class SellerDashboard extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.wow1,
      appBar: AppBar(
        backgroundColor: AppColor.wow3,
        title: const Text(
          'Seller Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.wow1,
        onPressed: () => Get.to(() => AddProductScreen()),
        child: const Icon(Icons.add, size: 30,color: AppColor.whiteColor,),
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return const Center(
            child: Text(
              'No Products Yet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            final imageWidget = product.image.startsWith('http')
                ? Image.network(
              product.image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image),
            )
                : Image.asset(
              product.image.isNotEmpty
                  ? product.image
                  : 'assets/images/de.jpg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            );

            return Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imageWidget,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Category: ${product.category}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Qty: ${product.quantity} • Price: \$${product.price}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () =>
                          productController.deleteProduct(product.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
