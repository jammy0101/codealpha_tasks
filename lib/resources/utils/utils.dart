import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../color/color.dart';


class Utils {

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor:  AppColor.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static snackBar(String title ,String message){
    Get.snackbar(
      title,
      message,
    );
  }

}