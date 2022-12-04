import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/cubits/payment/payment_state.dart';
import 'package:task/data/repository/card_repository.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/ui/card/widgets/for_cubit_textfield.dart';
import 'package:task/ui/card/widgets/my_card_item.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/my_utils.dart';
import 'package:task/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key, required this.bookSalary});

  final TextEditingController senderCardNumberController = TextEditingController();
  final TextEditingController receiverCardNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final double bookSalary;
   int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentErrorState) {
            Fluttertoast.showToast(msg: state.error);
          } else if (state is PaymentSuccessState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(state.data.message),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("Sender card number:"),
                            subtitle: Text(state.data.details.sender),
                          ),
                          ListTile(
                            title: const Text("Receiver:"),
                            trailing: Text(state.data.details.reciever),
                          ),
                          ListTile(
                            title: const Text("Receiver card number:"),
                            subtitle: Text(state.data.details.reciever_card_number),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        },
        builder: (context, state) => _scaffold(context, state));
  }

  Scaffold _scaffold(BuildContext context, PaymentState state) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: "To'lov Oynasi",
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Container(
                height: 3.h,
                width: 38.w,
                decoration: BoxDecoration(
                    // color: MyColors.neutral8,
                    borderRadius: BorderRadius.circular(100)),
              ),
              SizedBox(height: 12.h),
              Text(
                "Are you sure to pay?",
                style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm),
              ),
              SizedBox(height: 20.h),

              // qabul qiluvchi
              Text(
                "Qabul qiluvchi ",
                style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm, color: MyColors.buttonColor),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.only(left: 20.w),
                  height: 60,
                  decoration: BoxDecoration(border: Border.all(width: 2, color: MyColors.actionPrimaryDisabled), borderRadius: BorderRadius.circular(20.0)),
                  child: CubitController(
                    isEnabled: true,
                    initialValue: '8600060644551234',
                    controller: receiverCardNumberController,
                    text: 'Receiver card number',
                  )),

              // Jo'natuvchi
              Text(
                "Jo'natuvchi",
                style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm, color: MyColors.buttonColor),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 200,
                child: BlocBuilder<CardsCubit, CardsState>(
                  builder: (context, cardsState) {
                    var cards = cardsState.cards;
                    return PageView(
                      onPageChanged: (value) {
                        currentCard = value;
                      },
                      physics: const BouncingScrollPhysics(),
                        children: List.generate(
                      cards.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyCardItem(card: cards[index],),
                      ),
                    ));
                  },
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                "Kitob narxi ",
                style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm, color: MyColors.buttonColor),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.only(left: 20.w),
                  height: 60,
                  decoration: BoxDecoration(border: Border.all(width: 2, color: MyColors.actionPrimaryDisabled), borderRadius: BorderRadius.circular(20.0)),
                  child: CubitController(
isEnabled: true,
                    initialValue: bookSalary.toString(),
                    controller: amountController,
                    text: 'Amount',
                  )),
              SizedBox(height: 70,)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(7),
                  minimumSize: MaterialStateProperty.all(
                    const Size(250, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),

                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () async {
                  var myCard = context.read<CardsCubit>().state.cards[currentCard];
                  if(myCard.cardSalary -  bookSalary >=0 ){

                    await context.read<PaymentCubit>().transferMoney(
                      receiver: receiverCardNumberController.text.replaceAll(" ", ""),
                      amount: bookSalary.toString(),
                      sender: myCard.cardNum.replaceAll(" ", ""),
                    );
                    await CardsRepository(fireStore: FirebaseFirestore.instance).updateCardSalaryById(uid: myCard.cardId, price: myCard.cardSalary -  bookSalary);
                    await context.read<CardsCubit>().listenToUserCard(userId: FirebaseAuth.instance.currentUser!.uid.toString());
                  }else{
                    MyUtils.getMyToast(message: 'Pul yetarliy emas!');
                  }
                },
                child: state is PaymentLoadingState
                    ? const CircularProgressIndicator(
                        color: Colors.yellow,
                      )
                    : Text(
                        "Pul yuborish",
                        style: MyTextStyle.sfProSemibold.copyWith(color: MyColors.white, fontSize: 20),
                      )),
          ),
        ));
  }
}
