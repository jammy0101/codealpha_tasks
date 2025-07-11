import 'package:ecommerce/modal/ProductDetailScreen/ProductDetailScreen.dart';
import 'package:ecommerce/modal/productModel/product_Model.dart';
import 'package:ecommerce/view/categories/catogries.dart';
import 'package:ecommerce/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../authBinding/authBinding.dart';
import '../../services/splash_screen.dart';
import '../../view/cart/cartScreen.dart';
import '../../view/homeScreen/homeScreen.dart';
import '../../view/loginScreen/loginScreen.dart';
import '../../view/register/register.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.registrationScreen,
      page: () => RegistrationScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.category,
      page: () => Category(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.profile,
      page: () => Profile(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.cartScreen,
      page: () => CartScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // GetPage(
    //   name: RoutesName.productDetails,
    //   page: () => ProductDetailScreen(product: Product),
    //   binding: AuthBinding(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
    GetPage(
      name: RoutesName.productDetails,
      page: () => const Scaffold(body: Center(child: Text("No product provided"))),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),

  ];
}

