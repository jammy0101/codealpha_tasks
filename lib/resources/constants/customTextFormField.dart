import 'package:flutter/material.dart';
import '../color/color.dart';


class CustomTextFieldEmail extends StatelessWidget {
  const CustomTextFieldEmail({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: TextFormField(
        style: TextStyle(color: AppColor.blackColor),
        controller: controller,
        textCapitalization: TextCapitalization.words,
        decoration:  InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColor.blackColor),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
