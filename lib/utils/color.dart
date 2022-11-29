import 'package:flutter/material.dart';

class MyColors {
  static const Color buttonColor = Color(0xFF2C557D);
  static const Color C_E4E5E7 = Color(0xFFE4E5E7);
  static const Color C_2C557D = Color(0xFF2C557D);
  static const Color C_FAFAFD = Color(0xFFFAFAFD);
  static const Color C_95969D = Color(0xFF95969D);
  static const Color C_356899 = Color(0xFF356899);
  static const Color C_CACBCE = Color(0xFFCACBCE);
  static const Color primaryColor = Color(0xFF27459F);
  static const Color backgroundColor = Color(0xFFF3F5F9);
  static const Color C_0D0D26 = Color(0xFF0D0D26);
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color C_CFD5DE = Color(0xFFCFD5DE);
  static const Color black = Colors.black;
  static const Color textColor = Color(0xFF3E434D);
  static const Color C_F2F2F2 = Color(0xFFF2F2F2);
  static const Color C_5386e4 = Color(0xFF5386E4);
  static const Color C_039D57 = Color(0xFF039D57);
  static const Color C_5386E4 = Color(0xFF5386E4);

  static const Color C_E9E9EFF= Color(0xFFE9E9EF);
  static const Color C_BACCDC= Color(0xFFBACCDC);
  static const Color C_363636 = Color(0xFF363636);

  static const Color primary = Color(0xFF2972FE);
  static const Color error = Color(0xFFDA1414);

  static const Color actionPrimaryDefault = Color(0xFF2972FE);
  static Color actionPrimaryHover =
  Color.alphaBlend(Color(0xFF2972FE), Color(0xFFFFFFFF).withOpacity(0.2));
  static Color actionPrimaryActive =
  Color.alphaBlend(Color(0xFF2972FE), Color(0xFF000000).withOpacity(0.2));
  static const Color actionPrimaryDisabled = Color(0xFF93B8FE);
  static const Color actionPrimaryInverted = Color(0xFFFFFFFF);

  // Action Secondary
  static const Color actionSecondaryDefault = Color(0xFFFFB800);
  static Color actionSecondaryHover =
  Color.alphaBlend(Color(0xFFFFB800), Color(0xFFFFFFFF).withOpacity(0.2));
  static Color actionSecondaryActive =
  Color.alphaBlend(Color(0xFFFFB800), Color(0xFF000000).withOpacity(0.2));
  static const Color actionSecondaryDisabled = Color(0xFFFFB800);
  static const Color actionSecondaryInverted = Color(0xFFFFFFFF);



  static const Color neutralBlack = Color(0xFF09101D);
  static const Color neutral1 = Color(0xFF2C3A4B);
  static const Color neutral2 = Color(0xFF394452);
  static const Color neutral3 = Color(0xFF545D69);
  static const Color neutral4 = Color(0xFF6D7580);
  static const Color neutral5 = Color(0xFF858C94);
  static const Color neutral6 = Color(0xFFA5ABB3);
  static const Color neutral7 = Color(0xFFDADEE3);
  static const Color neutral8 = Color(0xFFEBEEF2);
  static const Color neutral9 = Color(0xFFF4F6F9);
  static const Color neutralWhite = Color(0xFFFFFFFF);

  // Accent
  static const Color accent1 = Color(0xFFECB2F2);
  static const Color accent2 = Color(0xFF2D6A6A);
  static const Color accent3 = Color(0xFFE9AD8C);
  static const Color accent4 = Color(0xFF221874);
  static const Color accent5 = Color(0xFF221874);
  static const Color accent6 = Color(0xFFE1604D);

  static const otherGradient1 = [Color(0xFF2972FE), Color(0xFF6499FF)];
  static const otherGradient2 = [Color(0xFFFFB800), Color(0xFFFFDA7B)];
  static List<Color> otherGradient3 = [
    Color(0xFFFF1843).withOpacity(0.9),
    Color(0xFFFF5E7C).withOpacity(0.9)
  ];
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffF86142,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFE6F6E1),
      100: Color(0xFFC1E8B5),
      200: Color(0xFF97D984),
      300: Color(0xFF6DC953),
      400: Color(0xFF4EBE2E),
      500: Color(0xFF2FB209),
      600: Color(0xFF2AAB08),
      700: Color(0xFF23A206),
      800: Color(0xFF1D9905),
      900: Color(0xFF128A02),
    },
  );
}
