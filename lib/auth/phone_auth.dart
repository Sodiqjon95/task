import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/user/user_cubit.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/widgets/phone_input_component.dart';
import 'package:task/widgets/register_button.dart';

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
                debugPrint(phone);
              },
              initialValue: '',
              caption: 'Telephone number',
            ),
            const SizedBox(height: 50),
            SizedBox(
              child:
              RegisterButton(
                onTap: ()async{
                  debugPrint("nomeri>>>>> ${countryCode + phone}");
                  await context.read<UserCubit>().singInWithPhoneNumber(number: phone, context: context);
                },
                title: "Register",
              )
            ),
          ],
        ),
      ),
    );
  }
}
