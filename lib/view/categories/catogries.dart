import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/mobile_modal/categoryModal.dart';
import '../../resources/color/color.dart';
import '../../resources/company_mobileServices/company_services.dart';
import '../../resources/customDrawer/bottumNavigation.dart';
import '../../viewModal/product_controller/product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final ProductController productController = Get.put(ProductController());
  Future<List<CategoryModel>> fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return CategoryModel.fromJson(data);
    }).toList();
  }

  final Map<String, String> categoryImages = {
    'Samsung': 'assets/images/samsung1.png',
    'iPhone': 'assets/images/iphone.png',
    'Vivo': 'assets/images/vivo.jpg',
    'Infinix': 'assets/images/infinixhot10.jpg',
    'RedMe': 'assets/images/RedMe.png',
    'Oppo': 'assets/images/opoo.jpg',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text('Category'),
        centerTitle: true,
        backgroundColor: AppColor.wow2,
      ),
      bottomNavigationBar: BottomNavigation(index: 1),
      body: FutureBuilder<List<CategoryModel>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () async {
                  final mobiles = await productController.getProductsByCategory(category.name);
                  Get.to(() => CompanyMobilesScreen(
                    brandName: category.name,
                    mobiles: mobiles,
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.wow3,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(
                            category.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // body: FutureBuilder<List<String>>(
      //   future: fetchCategories(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     final categories = snapshot.data!;
      //
      //     return GridView.builder(
      //       padding: const EdgeInsets.all(16),
      //       itemCount: categories.length,
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         mainAxisSpacing: 14,
      //         crossAxisSpacing: 14,
      //         childAspectRatio: 0.85,
      //       ),
      //       itemBuilder: (context, index) {
      //         final category = categories[index];
      //         final representativeImage = categoryImages[category] ?? 'assets/images/default.jpg';
      //
      //         return GestureDetector(
      //           onTap: () async {
      //             final mobiles = await productController.getProductsByCategory(category);
      //             Get.to(() => CompanyMobilesScreen(
      //               brandName: category,
      //               mobiles: mobiles,
      //             ));
      //           },
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: AppColor.wow3,
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: Column(
      //               children: [
      //                 Expanded(
      //                   child: ClipRRect(
      //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      //                     child: Image.asset(
      //                       representativeImage,
      //                       fit: BoxFit.cover,
      //                       width: double.infinity,
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text(
      //                     category,
      //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
