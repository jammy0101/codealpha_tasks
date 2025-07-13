import 'package:ecommerce/resources/category_services/category_services.dart';
import 'package:ecommerce/resources/routes/routes.dart';
import 'package:ecommerce/resources/routes/routes_name.dart';
import 'package:ecommerce/view/homeScreen/homeScreen.dart';
import 'package:ecommerce/viewModal/product_controller/product_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';
import 'modal/mobile_modal/mobil_modal.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await uploadCategoriesToFirestore(); // 👈 call this once
  Get.put(ProductController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

