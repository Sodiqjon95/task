import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/cubits/product/product2_cubit.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/ui/all_comment.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/constants.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/map_utils.dart';
import 'package:task/utils/my_utils.dart';
import 'package:task/utils/style.dart';
import 'package:task/widgets/all_comment.dart';
import 'package:task/widgets/comment_input_componenet.dart';
import 'package:task/widgets/global_button_outline.dart';
import 'package:task/widgets/info_short_text.dart';
import 'package:task/widgets/my_custom_button.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key, required this.productModel}) : super(key: key);
  final ProductModel productModel;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  TextEditingController messageController = TextEditingController();

  FocusNode focusNode = FocusNode();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // context.read<Product2Cubit>().listenToProductComment(productId: widget.productModel.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "Umumiy Ma'lumotlar",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 450,
                child: CachedNetworkImage(
                  imageUrl: (widget.productModel.imageUrl.isNotEmpty) ? widget.productModel.imageUrl : defaultImage,
                  fit: BoxFit.cover,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(height: 20),
              InfoText(
                info: widget.productModel.productName,
                title: 'Kitob nomi: ',
              ),
              InfoText(
                info: widget.productModel.salary.toString(),
                title: 'Kitob narxi: ',
              ),
              InfoText(
                info: widget.productModel.description,
                title: 'Batafsil: ',
              ),
              TextButton(
                  onPressed: () {
                    MapUtils.launchMap(widget.productModel.address);
                  },
                  child: const Text("Xaritadan ko'rish")),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.mapRoute);
                  },
                  child: const Text("Xaritada Xarakat")),
              const SizedBox(height: 20),
              MyCustomButton(
                buttonText: 'Sotib olish ${widget.productModel.salary}',
                onTap: () {
                  Navigator.popAndPushNamed(context, RouteNames.payment, arguments: widget.productModel.salary);
                  context.read<CardsCubit>().listenToUserCard(userId: user!.uid.toString());
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Fikr qoldiring",
                style: MyTextStyle.sfProBold.copyWith(fontSize: 20, color: MyColors.black),
              ),
              const SizedBox(height: 5),
              CommentInputComponent(
                onSubmitted: (value) {
                  focusNode.unfocus();
                },
                height: 100,
                onChanged: (String value) {},
                commentFocusNode: focusNode,
                hintText: 'fikr yozing',
                textEditingController: messageController,
                textButton: TextButton(
                  onPressed: () {
                    messageController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(height: 5),
              MyCustomButton(
                  buttonText: "Yuborish",
                  onTap: () async {
                    var comment = BlocProvider.of<Product2Cubit>(context);
                    if (messageController.text.isNotEmpty) {
                      comment.updateComment(
                        fieldValue: messageController.text,
                        fieldKey: 'text',
                      );
                      comment.updateComment(
                        fieldValue: widget.productModel.productId,
                        fieldKey: "product_id",
                      );
                      comment.updateComment(
                        fieldValue: user!.uid.toString(),
                        fieldKey: "user_id",
                      );
                      comment.updateComment(
                        fieldValue: user!.displayName,
                        fieldKey: "user_name",
                      );
                      comment.addComment();
                      messageController.clear();
                      MyUtils.getMyToast(message: 'Xabar yuborildi');
                    }
                    MyUtils.getMyToast(message: "Xabar bo'sh");
                  }),
              const SizedBox(height: 30),
              Text(
                "Bildirilgan Fikrlar",
                style: MyTextStyle.sfProBold.copyWith(fontSize: 20, color: MyColors.black),
              ),
              const SizedBox(height: 5),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                ),
                child: BlocBuilder<Product2Cubit, Product2State>(builder: (context, state) {
                  var st = state.status;
                  if (st == FormzStatus.submissionInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (st == FormzStatus.submissionSuccess) {
                    var comment = state.comment;
                    return comment.isNotEmpty
                        ? ListView(
                            children: List.generate(
                                comment.length,
                                (index) => AllCommentWidget(
                                      userName: comment[index].userName,
                                      text: comment[index].text,
                                    )),
                          )
                        : Center(child: Image.asset(MyIcons.inVacancies));
                  }
                  return const Center(child: Text("error"));
                }),
              ),
              const SizedBox(height: 5),
              GlobalButtonOutline(
                buttonText: "Barcha fikrlarni o'qish",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllComment(),
                    ),
                  );
                  context.read<Product2Cubit>().listenToProductComment(
                        productId: widget.productModel.productId,
                      );
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
