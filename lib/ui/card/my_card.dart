import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/widgets/global_button.dart';
import 'package:task/widgets/success_booking_dialog.dart';
import 'package:task/widgets/text_field.dart';

import 'widgets/card_expire_date_companent.dart';
import 'widgets/card_item.dart';

class BookingPaymentScreen extends StatefulWidget {
  const BookingPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  final TextEditingController fullNameController = TextEditingController();
  String expiryDate = '';
  String cardNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text("Payment"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline_sharp,
            ),
          ),
        ],
      ),
      // SingleIconAppBar(
      //   onTap: () {},
      //   title: 'Payment',
      //   svgIcon: ContentIcons.addCircleOutline,
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
        child: Column(
          children: [
            CardItem(
              cardHolderName: fullNameController.text,
              expireDate: expiryDate,
              cardNumber: (cardNum) {
                cardNumber = cardNum;
                setState(() {});
              },
            ),
            SizedBox(height: 24.h),
            MyTextField(
              controller: fullNameController,
              onChanged: (v) {
                setState(() {});
              },
              text: 'Full Name',
            ),
            SizedBox(height: 24.h),
            CardExpireDateComponent(
              cardText: (expireDate) {
                expiryDate = expireDate;
                setState(() {});
              },
              initialValue: '',
            ),
            SizedBox(height: 100.h),
            GlobalButton(
              buttonText: 'Pay Now',
              isActive: expiryDate.length == 5 && cardNumber.length == 19 && fullNameController.text != '',
              onTap: () {
                showDialog(
                  // barrierDismissible: false,
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    backgroundColor: Theme.of(context).backgroundColor,
                    insetPadding: EdgeInsets.symmetric(horizontal: 54.w),
                    child: SuccessBookingItem(
                      iconPath: MyIcons.messageFailed,
                      onPressed: () {},
                      message: 'Please make sure that your internet connection is active and stable, then press “Try Again”',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
