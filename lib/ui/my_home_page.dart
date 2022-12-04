import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/cubits/chats/chats_cubit.dart';
import 'package:task/cubits/product/product2_cubit.dart';
import 'package:task/cubits/user/user_cubit.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/data/models/user_item.dart';
import 'package:task/ui/card/custom_drawer.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/ui/card/widgets/products_widget.dart';
import 'package:task/ui/chat_page.dart';
import 'package:task/ui/detail.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/style.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> products = [];
  List<UserItem> users = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    context.read<CardsCubit>().listenToUserCard(userId: FirebaseAuth.instance.currentUser!.uid.toString());
    context.read<UserCubit>().listenUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: const CustomAppBar(
        onBackTap: null,
        title: "Online Do'kon",
        centerTitle: true,
      ),
      body: BlocBuilder<Product2Cubit, Product2State>(
        builder: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status == FormzStatus.submissionSuccess) {
            products = state.product;
            return ListView(children: [
              Container(
                height: 150,
                color: Colors.transparent,
                child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                  debugPrint("ifga keldik");
                  debugPrint(state.users.toString());
                  if (state.status == FormzStatus.submissionInProgress) {
                    print("ifga kedik");
                    return const Center(child: CircularProgressIndicator.adaptive());
                  } else if (state.status == FormzStatus.submissionSuccess) {
                    users = state.users;
                    return CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: false,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                            if (users[index].userId != user!.uid) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(usersReceiver: users[index].userId,),
                                        ));
                                    context.read<ChatsCubit>().getTwoUsersConversation(senderId: users[index].userId, receiverId: user!.uid.toString());
                                    debugPrint("meni uidiyim>>>> ${user!.uid.toString()}");
                                    debugPrint("tanlangan  userni uidisi >>>>${users[index].userId}");
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(radius: 40, child: Image.asset(MyIcons.userImg[1])),
                                      Text(
                                        users[index].userName,
                                        style: MyTextStyle.sfProBold.copyWith(color: MyColors.textColor),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                            return const SizedBox();
                          }},
                            childCount: users.length),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text("EMPTY"),
                  );
                }),
              ),
              ...List.generate(
                products.length,
                (index) {
                  var product = products[index];
                  return ProductButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            productModel: products[index],
                          ),
                        ),
                      );
                    },
                    imageUrl: product.imageUrl,
                    name: product.productName,
                    salary: product.salary,
                  );
                },
              ),
            ]);
          } else {
            return Center(child: Text(state.errorText));
          }
        },
      ),
    );
  }
}
