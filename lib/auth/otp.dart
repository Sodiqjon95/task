import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/phone_auth.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';
import 'package:task/widgets/my_custom_button.dart';
import 'package:pinput/pinput.dart';

class SMSCodeScreen extends StatefulWidget {
  const SMSCodeScreen({Key? key}) : super(key: key);

  @override
  State<SMSCodeScreen> createState() => _SMSCodeScreenState();
}

class _SMSCodeScreenState extends State<SMSCodeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var code = '';
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/img_6.png",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text("Enter your 6 digit here", textAlign: TextAlign.center, style: MyTextStyle.sfProRegular.copyWith(fontSize: 20, color: MyColors.black.withOpacity(0.5))),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child:
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value){
                    code = value;
                  },

                )
              // PinFieldAutoFill(
              //
              //   controller: textController,
              //   decoration: UnderlineDecoration(
              //     textStyle: MyTextStyle.sfProBold.copyWith(fontSize: 20, color: MyColors.black),
              //     colorBuilder: const FixedColorBuilder(MyColors.black),
              //   ),
              //   onCodeSubmitted: (value) {
              //     focusNode.unfocus();
              //   },
              //   onCodeChanged: (value) {
              //     code =value;
              //   },
              //   codeLength: 6,
              // ),
            ),
            const SizedBox(height: 50),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: MyCustomButton(
                    buttonText: "Login",
                    onTap: () {
                     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: PhoneAuth.verify, smsCode: code );
                    })),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
