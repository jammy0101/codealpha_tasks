import 'package:flutter/material.dart';

import '../color/color.dart';


class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onPress;
  final double height, width;
  final Color textColor, roundButton;

  const RoundButton({
    super.key,
    this.loading = false,
    required this.title,
    required this.onPress,
    this.width = 60,
    this.height = 50,
    required this.roundButton,
    required this.textColor,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: roundButton,
            borderRadius: BorderRadius.circular(13),
          ),
          child: loading
              ? const Center(
              child: CircularProgressIndicator()) : Center(
            child: Text(
              title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColor.whiteColor,fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}