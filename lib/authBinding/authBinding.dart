import 'package:get/get.dart';
import '../viewModal/firebase_services/firebase_services.dart';
import '../viewModal/product_controller/product_controller.dart';



class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseServices(), fenix: true);
    Get.put<ProductController>(ProductController());
  }
}
