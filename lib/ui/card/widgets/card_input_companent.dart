import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class CardInputComponent extends StatefulWidget {
  const CardInputComponent({
    Key? key,
    required this.cardText,
    required this.initialValue,
  }) : super(key: key);

  final ValueChanged<String> cardText;
  final String initialValue;

  @override
  State<CardInputComponent> createState() => _CardInputComponentState();
}

class _CardInputComponentState extends State<CardInputComponent> {
  late MaskTextInputFormatter cardMaskFormatter;
  final FocusNode cardFocusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  String shadowText = "XXXX XXXX XXXX XXXX";

  String updateShadowText(String currentText) {
    shadowText = "XXXX XXXX XXXX XXXX";
    shadowText = shadowText.substring(currentText.length, shadowText.length);
    return currentText + shadowText;
  }

  @override
  void initState() {
    cardMaskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    controller.text = cardMaskFormatter.maskText(widget.initialValue);
    updateShadowText(widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    cardFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: [cardMaskFormatter],
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      cursorColor: MyColors.buttonColor,
      focusNode: cardFocusNode,
      onChanged: (String value) {
        setState(() {
          if (value.length == 19) {
            cardFocusNode.unfocus();
          }
          widget.cardText.call(value);
          shadowText = updateShadowText(value);
        });
      },
      style: MyTextStyle.sfProBold
          .copyWith(fontSize: 25.sp, color: MyColors.white),
      decoration: InputDecoration(
        hintStyle: MyTextStyle.sfProBold
            .copyWith(fontSize: 27.sp, color: MyColors.primaryColor.withOpacity(0.5)),
        hintText: "Card Number",
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}
