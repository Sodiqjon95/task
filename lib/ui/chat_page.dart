import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/chats/chats_cubit.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/style.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.usersReceiver}) : super(key: key);
  final String usersReceiver;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messagingController = TextEditingController();
  late VoidCallback onTap;
  bool isMyMessage = false;
  User? user = FirebaseAuth.instance.currentUser;
  String userReceiver = '';

  final sodiqController = ScrollController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    userReceiver = widget.usersReceiver;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.neutral6,
      appBar: const CustomAppBar(
        title: "Chat",
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(builder: (context, state) {
        var st = state.status;

        if (st == FormzStatus.submissionInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (st == FormzStatus.submissionSuccess) {
          var chats = state.chats;
          return chats.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView(
                          controller: sodiqController,
                          padding: const EdgeInsets.all(20),
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                            chats.length,
                            (index) {
                              isMyMessage = chats[index].receiverId == user!.uid.toString();

                              return Container(
                                margin: EdgeInsets.only(
                                  right: isMyMessage ? 50 : 0,
                                  left: !isMyMessage ? 100 : 0,
                                  top: 10,
                                ),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(30.30),
                                      topRight: const Radius.circular(30.30),
                                      bottomLeft: isMyMessage ? const Radius.circular(0.0) : const Radius.circular(30),
                                      bottomRight: isMyMessage ? const Radius.circular(30.30) : const Radius.circular(0.0),
                                    )),
                                child: Text(
                                  chats[index].text,
                                  style: MyTextStyle.sfProBold.copyWith(fontSize: 18),
                                ),
                              );
                            },
                          )),
                    ),
                    Expanded(child: SizedBox())

                  ],
                )
              : Image.asset(MyIcons.inVacancies);
        }
        return const Center(child: Text("error"));
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 26.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: messagingController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: MyColors.white,
              fillColor: MyColors.white,
              filled: true,
              hintText: "Write a message ...",
              hintStyle: TextStyle(color: MyColors.black.withOpacity(0.5)),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: 28.0,
                ),
                onPressed: () async {
                  var chat = BlocProvider.of<ChatsCubit>(context);
                  final now = DateTime.now();
                  if (messagingController.text.isNotEmpty) {

                    chat.updateChat(fieldValue: messagingController.text, fieldKey: 'text');
                    chat.updateChat(fieldValue: now.toString(), fieldKey: 'creat_at');
                    chat.updateChat(fieldValue: userReceiver, fieldKey: 'receiver_id');
                    chat.updateChat(fieldValue: user!.uid, fieldKey: 'sender_id');
                    chat.addChat();


                  }
                  // onTap.call();
                  messagingController.clear();
                  //
                  // Future.delayed(Duration(milliseconds: 100),(){  setState(() {
                  //   sodiqController.jumpTo(
                  //       sodiqController.position.maxScrollExtent);
                  // });});
                },

              )),
          onChanged: (v) {
            sodiqController.jumpTo(
                sodiqController.position.maxScrollExtent);
          },

        ),
      ),
    );

  }
}
/*
TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: messagingController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hoverColor: MyColors.white,
                          fillColor: MyColors.white,
                          filled: true,
                          hintText: "Write a message ...",
                          hintStyle: TextStyle(color: MyColors.black.withOpacity(0.5)),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 28.0,
                            ),
                            onPressed: () async {
                              var chat = BlocProvider.of<ChatsCubit>(context);
                              final now = DateTime.now();
                              if (messagingController.text.isNotEmpty) {

                                chat.updateChat(fieldValue: messagingController.text, fieldKey: 'text');
                                chat.updateChat(fieldValue: now.toString(), fieldKey: 'creat_at');
                                chat.updateChat(fieldValue: userReceiver, fieldKey: 'receiver_id');
                                chat.updateChat(fieldValue: user!.uid, fieldKey: 'sender_id');
                                chat.addChat();
                              }
                              // onTap.call();
                              messagingController.clear();
                            },

                          )),
                      onChanged: (v) {
                        sodiqController.jumpTo(
                            sodiqController.position.maxScrollExtent);
                      },

                    ),
 */
