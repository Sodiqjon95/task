import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/style.dart';

// ignore: must_be_immutable
class AllCommentWidget extends StatelessWidget {
   AllCommentWidget({
    Key? key,
    required this.userName,
    required this.text,
  }) : super(key: key);

   String userName;
   String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: const EdgeInsets.all(10),

      decoration:
          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: MyColors.primary.withAlpha(80)), color: MyColors.actionPrimaryDisabled, boxShadow: [
        BoxShadow(
          color: MyColors.C_95969D.withOpacity(0.9),
          offset: const Offset(5, 4),
          blurRadius: 20,
        )
      ]),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(child: Image.asset(MyIcons.defaultUser)),
              const SizedBox(
                width: 10,
              ),
              Text(userName),
            ],
          ),
         const SizedBox(height: 10,),
         Text(text,style: MyTextStyle.sfProSemibold.copyWith(fontSize: 18),)
        ],
      ),
    );
  }
}
