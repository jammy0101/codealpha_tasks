// controllers/order_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../modal/mobile_modal/orderModal.dart';

class OrderController extends GetxController {
  final orders = <OrderModel>[].obs;
  final _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(OrderModel order) async {
    await _firestore.collection('orders').doc(order.id).set(order.toJson());
    orders.add(order);
  }

  Future<void> fetchUserOrders(String userId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    orders.value =
        snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _firestore.collection('orders').doc(orderId).update({'status': newStatus});
    final index = orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      orders[index] = orders[index].copyWith(status: newStatus);
      orders.refresh();
    }
  }
}
