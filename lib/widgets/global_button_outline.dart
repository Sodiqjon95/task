import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class GlobalButtonOutline extends StatelessWidget {
  const GlobalButtonOutline({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.isSmall = false,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onTap;
  final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.actionPrimaryDefault, width: 2),
        color: MyColors.transparent,
        borderRadius: BorderRadius.circular(32),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          //shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Text(
          buttonText,
          style: MyTextStyle.sfProSemibold.copyWith(
            fontSize: 18,
            color: MyColors.actionPrimaryDefault,
          ),
        ),
      ),
    );
  }
}
