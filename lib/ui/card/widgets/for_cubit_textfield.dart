import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class CubitController extends StatefulWidget {
  const CubitController({
    Key? key,
    required this.initialValue, required this.controller, required this.text, this.isEnabled,
  }) : super(key: key);

  final bool? isEnabled;
  final String initialValue;
  final String text;
  final TextEditingController controller;


  @override
  State<CubitController> createState() => _CubitControllerState();
}

class _CubitControllerState extends State<CubitController> {
  late MaskTextInputFormatter cardMaskFormatter;
  final FocusNode cardFocusNode = FocusNode();
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
    widget.controller.text = cardMaskFormatter.maskText(widget.initialValue);
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
      enabled: widget.isEnabled !=null ? false: true,
      controller: widget.controller,
      inputFormatters: [cardMaskFormatter],
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      cursorColor: MyColors.buttonColor,
      focusNode: cardFocusNode,
      // onChanged: (String value) {
      //   setState(() {
      //     if (value.length == 19) {
      //       cardFocusNode.unfocus();
      //     }
      //     widget.cardText.call(value);
      //     shadowText = updateShadowText(value);
      //   });
      // },
      style: MyTextStyle.sfProBold
          .copyWith(fontSize: 25.sp, color: MyColors.black),
      decoration: InputDecoration(
        hintStyle: MyTextStyle.sfProBold
            .copyWith(fontSize: 27.sp, color: MyColors.primaryColor.withOpacity(0.5)),
        hintText: widget.text,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}
