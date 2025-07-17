// order_tracking_screen.dart
import 'package:flutter/material.dart';
import '../../modal/mobile_modal/orderModal.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  OrderTrackingScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Tracking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Order Status: ${order.status}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ...order.items.map((item) => ListTile(
              title: Text(item.name),
              subtitle: Text("${item.quantity} × \$${item.price}"),
            )),
          ],
        ),
      ),
    );
  }
}
