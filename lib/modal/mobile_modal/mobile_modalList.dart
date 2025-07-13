// import 'mobil_modal.dart';
//
// List<MobileModel> mobileList = [
//   MobileModel(
//     id: '1',
//     name: 'Samsung S24 Ultra',
//     image: 'assets/images/samsung1.png',
//     category: 'Samsung',
//     price: 1499.0,
//     description: 'Experience cutting-edge innovation with the Samsung S24 Ultra, featuring a dynamic AMOLED display, pro-grade camera, and powerful performance for multitasking and gaming.',
//   ),
//   MobileModel(
//     id: '2',
//     name: 'Vivo Y15',
//     image: 'assets/images/vivo.jpg',
//     category: 'Vivo',
//     price: 499.0,
//     description: 'The Vivo Y15 offers a perfect blend of style and performance with a massive battery, AI triple camera setup, and a sleek design ideal for everyday use.',
//   ),
//   MobileModel(
//     id: '3',
//     name: 'Infinix Hot 10',
//     image: 'assets/images/infinixhot10.jpg',
//     category: 'Infinix',
//     price: 299.0,
//     description: 'Stay entertained on the go with the Infinix Hot 10, equipped with a large HD+ display, long-lasting battery, and octa-core processor at an affordable price.',
//   ),
//   MobileModel(
//     id: '4',
//     name: 'iPhone 15 Pro',
//     image: 'assets/images/iphone.png',
//     category: 'iPhone',
//     price: 1999.0,
//     description: 'Redefine premium with the iPhone 15 Pro, boasting an A17 Bionic chip, titanium design, pro-level camera system, and the all-new Action button.',
//   ),
//   MobileModel(
//     id: '5',
//     name: 'Xiaomi Redmi 13C',
//     image: 'assets/images/RedMe.png',
//     category: 'RedMe',
//     price: 999.0,
//     description: 'The Redmi 13C offers stunning value with a large display, fast charging, and a high-resolution camera, perfect for work and play on a budget.',
//   ),
//   MobileModel(
//     id: '6',
//     name: 'Oppo',
//     image: 'assets/images/opoo.jpg',
//     category: 'Oppo',
//     price: 699.0,
//     description: 'Enjoy a smooth and stylish experience with Oppo\'s latest phone, combining sleek design, long battery life, and excellent camera performance.',
//   ),
//   MobileModel(
//     id: '7',
//     name: 'Oppo A5 Pro',
//     image: 'assets/images/oppoA5.jpg',
//     category: 'Oppo',
//     price: 749.0,
//     description: 'The Oppo A5 Pro is packed with features including a large display, dual rear cameras, and a powerful battery, perfect for multimedia lovers.',
//   ),
// ];
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../viewModal/product_controller/product_controller.dart';

final ProductController productController = Get.put(ProductController());

Future<List<String>> fetchCategories() async {
  final snapshot = await FirebaseFirestore.instance.collection('products').get();
  final allCategories = snapshot.docs.map((doc) => doc['category'] as String).toSet().toList();
  return allCategories;
}
