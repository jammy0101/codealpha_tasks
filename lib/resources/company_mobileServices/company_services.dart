// import 'package:flutter/material.dart';
// import '../../modal/mobile_modal/mobil_modal.dart';
// import '../../resources/color/color.dart';
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
//       backgroundColor: AppColor.whiteColor,
//       appBar: AppBar(
//         title: Text(brandName),
//         backgroundColor: AppColor.wow2,
//         centerTitle: true,
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(14),
//         itemCount: mobiles.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.72,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemBuilder: (context, i) {
//           final mobile = mobiles[i];
//           return Container(
//             decoration: BoxDecoration(
//               color: AppColor.wow3,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                     child: Image.asset(
//                       mobile.image,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     mobile.name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/ProductDetailScreen/ProductDetailScreen.dart';
import '../../modal/mobile_modal/mobil_modal.dart';
import '../../resources/color/color.dart';
import '../../viewModal/product_controller/product_controller.dart';


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
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) {
          final mobile = mobiles[i];
          return GestureDetector(
            onTap: () {
              // Optional: navigate to ProductDetail screen
              Get.to(() => ProductDetailScreen(product: mobile));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.wow3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        mobile.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    child: Column(
                      children: [
                        Text(
                          mobile.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$${mobile.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {
                            productController.addToCart(mobile);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.wow1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 13,color: AppColor.whiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
