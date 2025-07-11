import 'package:ecommerce/resources/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes_name.dart';


class BottomNavigation extends StatefulWidget {
  final int index;
  const BottomNavigation({super.key, required this.index});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int myIndex = widget.index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        elevation: 2,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: AppColor.wow3,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == myIndex) return; // Prevents reloading the same screen

          setState(() {
            myIndex = index;
          });

          switch (index) {
            case 0:
              Get.offAllNamed(RoutesName.homeScreen);
              break;
            case 1:
              Get.offAllNamed(RoutesName.category);
              break;
            case 2:
              Get.offAllNamed(RoutesName.cartScreen);
              break;
            case 3:
              Get.offAllNamed(RoutesName.profile);
              break;
          }
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'category',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'cart',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'profile',
              backgroundColor: Colors.white),
        ],
      ),
    );
  }
}
