// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<void> uploadMobilesToFirestore() async {
//   final List<Map<String, dynamic>> mobiles = [
//     {
//       'id': '1',
//       'name': 'Samsung S24 Ultra',
//       'category': 'Samsung',
//       'price': 1499.0,
//       'description': 'Experience cutting-edge innovation with the Samsung S24 Ultra, featuring a dynamic AMOLED display, pro-grade camera, and powerful performance for multitasking and gaming.',
//       'image': 'assets/images/samsung1.png',
//       'quantity': 1,
//     },
//     {
//       'id': '2',
//       'name': 'Vivo Y15',
//       'category': 'Vivo',
//       'price': 499.0,
//       'description': 'The Vivo Y15 offers a perfect blend of style and performance with a massive battery, AI triple camera setup, and a sleek design ideal for everyday use.',
//       'image': 'assets/images/vivo.jpg',
//       'quantity': 1,
//     },
//     {
//       'id': '3',
//       'name': 'Infinix Hot 10',
//       'category': 'Infinix',
//       'price': 299.0,
//       'description': 'Stay entertained on the go with the Infinix Hot 10, equipped with a large HD+ display, long-lasting battery, and octa-core processor at an affordable price.',
//       'image': 'assets/images/infinixhot10.jpg',
//       'quantity': 1,
//     },
//     {
//       'id': '4',
//       'name': 'iPhone 15 Pro',
//       'category': 'iPhone',
//       'price': 1999.0,
//       'description': 'Redefine premium with the iPhone 15 Pro, boasting an A17 Bionic chip, titanium design, pro-level camera system, and the all-new Action button.',
//       'image': 'assets/images/iphone.png',
//       'quantity': 1,
//     },
//     {
//       'id': '5',
//       'name': 'Xiaomi Redmi 13C',
//       'category': 'RedMe',
//       'price': 999.0,
//       'description': 'The Redmi 13C offers stunning value with a large display, fast charging, and a high-resolution camera, perfect for work and play on a budget.',
//       'image': 'assets/images/RedMe.png',
//       'quantity': 1,
//     },
//     {
//       'id': '6',
//       'name': 'Oppo A58',
//       'category': 'Oppo',
//       'price': 699.0,
//       'description': 'Enjoy a smooth and stylish experience with Oppo\'s latest phone, combining sleek design, long battery life, and excellent camera performance.',
//       'image': 'assets/images/opoo.jpg',
//       'quantity': 1,
//     },
//     {
//       'id': '7',
//       'name': 'Oppo A5 Pro',
//       'category': 'Oppo',
//       'price': 749.0,
//       'description': 'The Oppo A5 Pro is packed with features including a large display, dual rear cameras, and a powerful battery, perfect for multimedia lovers.',
//       'image': 'assets/images/oppoA5.jpg',
//       'quantity': 1,
//     },
//   ];
//
//
//   final collection = FirebaseFirestore.instance.collection('products');
//   for (final mobile in mobiles) {
//     await collection.doc(mobile['id']).set(mobile);
//   }
//
//   print('✅ Mobiles uploaded');
// }
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoriesToFirestore() async {
  final categories = [
    {
      'name': 'Samsung',
      'image': 'assets/images/samsung1.png',
    },
    {
      'name': 'Vivo',
      'image': 'assets/images/vivo.jpg',
    },
    {
      'name': 'Infinix',
      'image': 'assets/images/infinixhot10.jpg',
    },
    {
      'name': 'iPhone',
      'image': 'assets/images/iphone.png',
    },
    {
      'name': 'RedMe',
      'image': 'assets/images/RedMe.png',
    },
    {
      'name': 'Oppo',
      'image': 'assets/images/opoo.jpg',
    },
  ];

  final collection = FirebaseFirestore.instance.collection('categories');

  for (final category in categories) {
    await collection.doc(category['name']).set(category);
  }

  print('✅ Categories uploaded');
}
