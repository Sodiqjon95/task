import 'package:flutter/material.dart';
import 'package:task/ui/card/widgets/card_input_companent.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(title: Text("tolov"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment,
        children: [
          SizedBox(height: 100,),
          CardInputComponent(cardText: (String value) {
            print(value);

          }, initialValue: '',)
      ],),
    );
  }
}
