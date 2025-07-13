// import '../../modal/mobile_modal/mobil_modal.dart';
// import '../../modal/mobile_modal/mobile_modalList.dart';
//
// class ProductService {
//   List<MobileModel> fetchProducts() {
//     return mobileList; // return your static list
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../modal/mobile_modal/mobil_modal.dart';
//
// class ProductService {
//   final _firestore = FirebaseFirestore.instance;
//
//   Future<List<MobileModel>> fetchProducts() async {
//     final snapshot = await _firestore.collection('products').get();
//
//     return snapshot.docs.map((doc) => MobileModel.fromJson(doc.data())).toList();
//   }
// }
