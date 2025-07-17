// order_history_screen.dart
import 'package:ecommerce/resources/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewModal/orderController/oredrController.dart';

class OrderHistoryScreen extends StatelessWidget {
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.wow3,
      appBar: AppBar(
        centerTitle: true,
          title: Text("My Orders",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return Center(child: Text("No Orders Yet"));
        }
        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text("Order #${order.id}"),
                subtitle: Text(
                    "${order.items.length} items • \$${order.total} • ${order.status}"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to tracking screen or order details
                },
              ),
            );
          },
        );
      }),
    );
  }
}
