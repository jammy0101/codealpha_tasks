import 'package:ecommerce/resources/color/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/customDrawer/bottumNavigation.dart';
import '../../resources/customDrawer/drawer.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Category'),
        centerTitle: true,
        backgroundColor: AppColor.wow2,
      ),
      // drawer: CustomDrawer(auth: FirebaseAuth.instance,),
      bottomNavigationBar:  BottomNavigation(index: 1,),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
