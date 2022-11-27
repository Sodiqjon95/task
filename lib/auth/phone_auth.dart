import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/otp.dart';
import 'package:task/utils/constants.dart';
import 'package:task/utils/icon.dart';
import 'package:task/widgets/phone_input_component.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  static String verify = '';

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController textEditingController = TextEditingController();

  String phone = '';
  String countryCode = '+998 ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LottieBuilder.asset(MyIcons.register),
            Image.asset(MyIcons.mapLogo),
            PhoneInputComponent(
              phoneText: (String value) {
                phone = value;
                print(phone);
              },
              initialValue: '',
              caption: 'Telephone number',
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  minimumSize: MaterialStateProperty.all(
                    const Size(250, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () async {
                  debugPrint("nomerrrrrr>>>>> ${countryCode + phone}");
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: countryCode + phone,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      PhoneAuth.verify = verificationId;
                      Navigator.pushNamed(context, RouteNames.otp);
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );

                  // await FirebaseAuth.instance.verifyPhoneNumber(
                  //   phoneNumber: countryCode + phone,
                  //   verificationCompleted: (PhoneAuthCredential credential) {},
                  //   verificationFailed: (FirebaseAuthException e) {},
                  //   codeSent: (String verificationId, int? resendToken) {
                  //     PhoneAuth.verify = verificationId;
                  //     Navigator.pushNamed(context, 'otp');
                  //   },
                  //   codeAutoRetrievalTimeout: (String verificationId) {},
                  // );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

          ],
        ),

      ),

    );
  }
}
