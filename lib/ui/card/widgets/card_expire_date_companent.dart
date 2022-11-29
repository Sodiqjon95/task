import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/style.dart';

class CardExpireDateComponent extends StatefulWidget {
  const CardExpireDateComponent({
    Key? key,
    required this.cardText,
    required this.initialValue,
  }) : super(key: key);

  final ValueChanged<String> cardText;
  final String initialValue;

  @override
  State<CardExpireDateComponent> createState() => _CardExpireDateComponentState();
}

class _CardExpireDateComponentState extends State<CardExpireDateComponent> {
  late MaskTextInputFormatter cardMaskFormatter;
  final FocusNode cardFocusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    cardMaskFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    controller.text = cardMaskFormatter.maskText(widget.initialValue);

    super.initState();
  }

  @override
  void dispose() {
    cardFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20.w),
            Text('Expiry Date', style: MyTextStyle.sfBold800.copyWith(color: MyColors.neutral1.withOpacity(0.8), fontSize: 16.sp)),
            Text("*", style: MyTextStyle.sfBold800.copyWith(color: MyColors.error)),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 164.w,
          child: TextFormField(
            controller: controller,
            inputFormatters: [cardMaskFormatter],
            keyboardType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            cursorColor: MyColors.primary,
            focusNode: cardFocusNode,
            onChanged: (String value) {
              if (controller.text.length == 2 && int.parse(controller.text[0] + controller.text[1]) > 12) {
                // controller.clear();
                controller.clear();
              } else if (value.length == 5) {
                cardFocusNode.unfocus();
              }
              widget.cardText.call(controller.text);
            },
            style: MyTextStyle.sfProBold.copyWith(
              fontSize: 16.sp,
              color: MyColors.black,
            ),
            decoration: InputDecoration(
              hintText: 'MM/YY',
              hintStyle: MyTextStyle.sfBold800.copyWith(color: MyColors.neutral7, fontSize: 16.sp),
              contentPadding: EdgeInsets.only(left: 20.w),
              filled: true,
              suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.w, top: 12.h, bottom: 12.h),
                  child: SvgPicture.asset(
                    MyIcons.eventNote,
                    color: MyColors.neutral5,
                  )),
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
                borderSide: const BorderSide(color: MyColors.neutral8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
                borderSide: const BorderSide(color: MyColors.primary, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
                borderSide: const BorderSide(color: MyColors.error),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
                borderSide: const BorderSide(color: MyColors.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
