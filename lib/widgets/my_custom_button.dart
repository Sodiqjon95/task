import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: MyColors.buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: MyTextStyle.sfProRegular.copyWith(fontSize: 20, color: MyColors.white),
          ),
        ),
      ),
    );
  }
}
