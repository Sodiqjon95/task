import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class ActiveButton extends StatelessWidget {
  ActiveButton({
    Key? key,
    required this.buttonText,
    this.width,
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: MyColors.buttonColor,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 16)
          ),
        ),
      ),
    );
  }
}
