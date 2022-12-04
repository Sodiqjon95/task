import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class InfoText extends StatelessWidget {
  final String title;
  final String info;
  bool isUrl;

  InfoText({super.key, required this.info, required this.title, this.isUrl = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: info.length < 40
          ? Row(
              children: [
                Text(
                  title,
                  style: MyTextStyle.sfProBold.copyWith(fontSize: 15, color: MyColors.C_95969D),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Text(
                    info,
                    textAlign: TextAlign.end,
                    style: MyTextStyle.sfProMedium.copyWith(fontSize: 15),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTextStyle.sfProBold.copyWith(color: MyColors.C_95969D, fontSize: 15),
                ),
                Text(info, style: MyTextStyle.sfProMedium.copyWith(fontSize: 16)),
              ],
            ),
    );
  }
}
