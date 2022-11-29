import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/color.dart';
import 'package:task/widgets/global_button.dart';

import '../utils/style.dart';

class SuccessBookingItem extends StatelessWidget {
  const SuccessBookingItem(
      {super.key,
        required this.iconPath,
        required this.onPressed,
        required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*2/3,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Image.asset(iconPath, height: 192.h),
          SizedBox(height: 24.h),
          Text(
            'Successful',
            style: MyTextStyle.sfBold800.copyWith(
              fontSize: 29.sp,
              color: MyColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            maxLines: 5,
            style: MyTextStyle.sfProRegular.copyWith(
              fontSize: 16.sp,
              color: MyColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          GlobalButton(
            isActive: true,
            buttonText: 'OK',
            onTap: onPressed,
          ),
        ],
      ),
    );
  }

  final String iconPath;
  final VoidCallback onPressed;
  final String message;
}
