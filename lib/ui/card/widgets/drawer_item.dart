import 'package:flutter/material.dart';
import 'package:task/utils/color.dart';
import '../../../utils/style.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({Key? key, required this.title, required this.icon, this.itemColor, required this.onPressed}) : super(key: key);
  final String title;
  final IconData icon;
  final Color? itemColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 26,
      leading: Icon(
        icon,
        size: 26,
        color: itemColor ?? MyColors.C_95969D,
      ),
      title: Text(
        title,
        style: MyTextStyle.sfProRegular.copyWith(fontSize: 18, color: itemColor ?? MyColors.C_0D0D26),
      ),
      onTap: () {
        Navigator.pop(context);
        onPressed();
      },
    );
  }
}
