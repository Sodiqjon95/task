import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/ui/card/my_card.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController fullNameController = TextEditingController();
  String expiryDate = '';
  String cardNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar:  const CustomAppBar(title: "Karta qo'shish",),
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
                var card = BlocProvider.of<CardsCubit>(context);
                card.updateCard(fieldValue: cardNumber, fieldKey: "card_num");
                card.updateCard(fieldValue: fullNameController.text, fieldKey: "holder_name");
                card.updateCard(fieldValue: user?.uid, fieldKey: "user_id");
                card.updateCard(fieldValue: 5000000.0, fieldKey: "card_salary");
                card.updateCard(fieldValue: expiryDate, fieldKey: "expiry_data");
                card.addCard();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    backgroundColor: Theme.of(context).backgroundColor,
                    insetPadding: EdgeInsets.symmetric(horizontal: 54.w),
                    child: SuccessBookingItem(
                      iconPath: MyIcons.message,
                      onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context)=> MyCards()));
                      },
                      message: "Karta ma'lumotlari muvofiqiyatlik qo'shildi",
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
