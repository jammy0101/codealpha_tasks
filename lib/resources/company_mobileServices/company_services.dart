// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../modal/ProductDetailScreen/ProductDetailScreen.dart';
// // import '../../modal/mobile_modal/mobil_modal.dart';
// // import '../../resources/color/color.dart';
// // import '../../viewModal/product_controller/product_controller.dart';
// //
// //
// // class CompanyMobilesScreen extends StatelessWidget {
// //   final String brandName;
// //   final List<MobileModel> mobiles;
// //
// //   const CompanyMobilesScreen({
// //     super.key,
// //     required this.brandName,
// //     required this.mobiles,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final ProductController productController = Get.find<ProductController>();
// //
// //     return Scaffold(
// //       backgroundColor: AppColor.whiteColor,
// //       appBar: AppBar(
// //         title: Text(brandName),
// //         backgroundColor: AppColor.wow2,
// //         centerTitle: true,
// //       ),
// //       body: GridView.builder(
// //         padding: const EdgeInsets.all(14),
// //         itemCount: mobiles.length,
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           childAspectRatio: 0.65,
// //           crossAxisSpacing: 10,
// //           mainAxisSpacing: 10,
// //         ),
// //         itemBuilder: (context, i) {
// //           final mobile = mobiles[i];
// //           return GestureDetector(
// //             onTap: () {
// //               // Optional: navigate to ProductDetail screen
// //               Get.to(() => ProductDetailScreen(product: mobile));
// //             },
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: AppColor.wow3,
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Expanded(
// //                     child: ClipRRect(
// //                       borderRadius:
// //                       const BorderRadius.vertical(top: Radius.circular(10)),
// //                       child: Image.asset(
// //                         mobile.image,
// //                         fit: BoxFit.cover,
// //                         width: double.infinity,
// //                       ),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           mobile.name,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 15,
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           "\$${mobile.price}",
// //                           style: const TextStyle(
// //                             fontSize: 14,
// //                             color: Colors.black87,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 6),
// //                         ElevatedButton(
// //                           onPressed: () {
// //                             productController.addToCart(mobile);
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColor.wow1,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                           ),
// //                           child: const Text(
// //                             "Add to Cart",
// //                             style: TextStyle(fontSize: 13,color: AppColor.whiteColor),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../modal/mobile_modal/mobil_modal.dart';
// import '../color/color.dart';
//
// class CompanyMobilesScreen extends StatelessWidget {
//   final String brandName;
//   final List<MobileModel> mobiles;
//
//   const CompanyMobilesScreen({
//     super.key,
//     required this.brandName,
//     required this.mobiles,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(brandName),
//         centerTitle: true,
//         backgroundColor: AppColor.wow2,
//       ),
//       body: ListView.builder(
//         itemCount: mobiles.length,
//         itemBuilder: (context, index) {
//           final mobile = mobiles[index];
//           return ListTile(
//             leading: Image.asset(mobile.image, width: 50),
//             title: Text(mobile.name),
//             subtitle: Text("\$${mobile.price}"),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/mobile_modal/mobil_modal.dart';
import '../../resources/color/color.dart';
import '../../viewModal/product_controller/product_controller.dart';
import '../../modal/ProductDetailScreen/ProductDetailScreen.dart';

class CompanyMobilesScreen extends StatelessWidget {
  final String brandName;
  final List<MobileModel> mobiles;

  const CompanyMobilesScreen({
    super.key,
    required this.brandName,
    required this.mobiles,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: AppColor.wow2,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: mobiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.99,
          crossAxisSpacing: 1,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) {
          final mobile = mobiles[i];
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailScreen(product: mobile));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade300,
                    blurRadius: 9,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        mobile.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mobile.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$${mobile.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              productController.addToCart(mobile);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.wow1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
