import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/ui/card/widgets/card_input_companent.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/card/card.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/style.dart';


class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
        required this.cardHolderName,
        required this.expireDate,
        required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.5.r),
              gradient: const LinearGradient(
                colors: MyColors.otherGradient1,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          Positioned(
            child: SvgPicture.asset(CardIcons.cardVector1),
          ),
          Positioned(
            left: 15.w,
            child: SvgPicture.asset(CardIcons.cardVector2),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(CardIcons.cardVector3),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 33.h, left: 34.w, right: 26.w, bottom: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credit card',
                  style: MyTextStyle.sfProBold.copyWith(
                    fontSize: 16.sp,
                    color: MyColors.white,
                  ),
                ),
                const Spacer(),
                CardInputComponent(
                  cardText: (cardText) {
                    cardNumber.call(cardText);
                  },
                  initialValue: '',
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Holder name',
                          style: MyTextStyle.sfProRegular.copyWith(
                            fontSize: 9.sp,
                            color: MyColors.white,
                          ),
                        ),
                        SizedBox(height: 9.h),
                        SizedBox(
                          width: 85.w,
                          child: Text(
                            cardHolderName,
                            maxLines: 2,
                            style: MyTextStyle.sfBold800.copyWith(
                              fontSize: 15.sp,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 52.5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry date',
                          style: MyTextStyle.sfProRegular.copyWith(
                            fontSize: 9.sp,
                            color: MyColors.white,
                          ),
                        ),
                        SizedBox(height: 9.h),
                        Text(
                          expireDate,
                          style: MyTextStyle.sfBold800.copyWith(
                            fontSize: 15.sp,
                            color: MyColors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(MyIcons.uzCard, height: 10.h)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  final String cardHolderName;
  final String expireDate;
  final ValueChanged<String> cardNumber;
}
