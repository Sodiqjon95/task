import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/ui/card/add_my_card.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/ui/card/widgets/my_card_item.dart';
import 'package:task/utils/icons/icon.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key? key}) : super(key: key);

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Cards"),
      body: BlocBuilder<CardsCubit, CardsState>(
        builder: (context, state) {
          var st = state.status;
          if (st == FormzStatus.submissionInProgress) {
            print("status >>>> $st");
            return const Center(child: CircularProgressIndicator());
          } else if (st == FormzStatus.submissionSuccess) {
            var cards = state.cards;
            debugPrint(cards.toString());
            return cards.isNotEmpty
                ? ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    children: [
                      ...List.generate(cards.length, (index) {
                        debugPrint("card >>>> $cards.toString()");
                        return MyCardItem(
                          card: cards[index],
                        );
                      })
                    ],
                  )
                : Center(child: IconButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPaymentScreen(),
                  ));
            },icon: Icon(Icons.add),));
          } else if (st == FormzStatus.submissionFailure) {
            print("status error >>>> $st");

            return Center(child: Text(state.errorText));
          }
          return const Center(child: Text("error"));
        },
      ),
    );
  }
}
