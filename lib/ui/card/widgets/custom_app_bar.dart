import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({Key? key, this.onBackTap, this.title, this.centerTitle, this.helperIcon, this.onTapHelper}) : super(key: key);

  final VoidCallback? onBackTap;
  final VoidCallback? onTapHelper;
  final String? title;
  final bool? centerTitle;
  final bool? helperIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Palette.kToDark.shade200,
      elevation: 0,
      centerTitle: centerTitle ?? false,
      title: Text(title ?? "",
          style: MyTextStyle.sfBold800.copyWith(fontSize: 20,color: MyColors.textColor)),
      leading: onBackTap != null
          ? IconButton(
              onPressed: onBackTap,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
          : null,
      actions: [
        helperIcon == true ?
        IconButton(onPressed: onTapHelper, icon: const Icon(Icons.assignment_late)):const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget get child => throw UnimplementedError();
}
