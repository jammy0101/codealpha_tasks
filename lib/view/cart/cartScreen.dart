import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../resources/color/color.dart';
import '../../resources/customDrawer/bottumNavigation.dart';
import '../../resources/customDrawer/drawer.dart';
import '../../viewModal/product_controller/product_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController productController = Get.find<ProductController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
          title: Text('My Cart'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.wow2,
      ),
      //drawer: CustomDrawer(auth: FirebaseAuth.instance,),
      bottomNavigationBar:  BottomNavigation(index: 2,),
      body: Obx(() => ListView.builder(
        itemCount: productController.cart.length,
        itemBuilder: (_, index) {
          final item = productController.cart[index];
          return ListTile(
            leading: Image.asset(item.imageUrl, width: 50, height: 50),
            title: Text(item.name),
            subtitle: Text("\$${item.price}"),
          );
        },
      )),
    );
  }
}