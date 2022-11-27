import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/phone_auth.dart';
import 'package:task/ui/my_home_page.dart';
import 'package:task/utils/icon.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
      splash: MyIcons.appLogo,
      nextScreen: const PhoneAuth(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}