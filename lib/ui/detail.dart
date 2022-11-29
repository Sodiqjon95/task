import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/ui/card/widgets/card_input_companent.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/constants.dart';
import 'package:task/utils/style.dart';
import 'package:task/widgets/global_button_outline.dart';

import '../widgets/global_button.dart';

class ProductDetail extends StatefulWidget {
   ProductDetail({Key? key,required this.productModel, required this.index }) : super(key: key);
  final ProductModel productModel;
  int index;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  const CustomAppBar(
        title: "Umumiy Ma'lumotlar",
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: (widget.productModel.imageUrl.isNotEmpty) ? widget.productModel.imageUrl : defaultImage,
                fit: BoxFit.cover,
                height: 400,
                width: MediaQuery.of(context).size.width,
              ),
            ),
              TextButton(onPressed: () {}, child: const Text('Map')),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: shoDeleteDialog, child: const Text("to'lov")),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: () {}, child: const Text("chat qismi")),
            ],
          ),
        ),
      ),
    );
  }

  shoDeleteDialog() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.0.r))),
        // backgroundColor: MyColors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Column(
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
                Text(
                  "Qabul qiluvchi ",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm, color: MyColors.buttonColor),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.only(left: 20.w),
                  height: 60,
                  decoration: BoxDecoration(border: Border.all(width: 2, color: MyColors.actionPrimaryDisabled), borderRadius: BorderRadius.circular(20.0)),
                  child: CardInputComponent(
                    cardText: (String value) {},
                    initialValue: '',
                  ),
                ),
                Text(
                  "Jo'natuvchi",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16.sm, color: MyColors.buttonColor),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: EdgeInsets.only(left: 20.w),
                    height: 60,
                    decoration: BoxDecoration(border: Border.all(width: 2, color: MyColors.actionPrimaryDisabled), borderRadius: BorderRadius.circular(20.0)),
                    child: CardInputComponent(
                      cardText: (String value) {},
                      initialValue: '',
                    ),
                  ),
                ),
                Text(
                  "Summa 30 000",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 20.sm, color: MyColors.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GlobalButtonOutline(
                          buttonText: 'Cancel',
                          onTap: () {},
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                          child: GlobalButton(
                        isActive: true,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonText: 'Yes, Pay',
                      )),
                    ],
                  ),
                ),

              ],
            ));
  }
}
