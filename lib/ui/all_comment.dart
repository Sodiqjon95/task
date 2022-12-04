import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/product/product2_cubit.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/widgets/all_comment.dart';

class AllComment extends StatelessWidget {
  const AllComment({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Barcha fikrlar",
      ),
      body: BlocBuilder<Product2Cubit, Product2State>(
        builder: (context, state) {
          var st = state.status;
          if (st == FormzStatus.submissionInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (st == FormzStatus.submissionSuccess) {
            var comment = state.comment;
            return comment.isNotEmpty
                ? ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    children: [
                      ...List.generate(comment.length, (index){
                        return AllCommentWidget(
                          userName: comment[index].userName,
                        text: comment[index].text,);
                      })
                    ],
                  )
                : Image.asset(MyIcons.inVacancies);
          }
          return const Center(child: Text("error"));
        },
      ),
    );
  }
}
