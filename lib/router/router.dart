import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/otp.dart';
import 'package:task/ui/my_home_page.dart';
import 'package:task/ui/splash_page.dart';
import '../utils/constants.dart';

class MyRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return navigateTo(SplashScreen());

        case RouteNames.otp:
        return navigateTo(SMSCodeScreen());

        case RouteNames.home:
        return navigateTo(MyHomePage());
      default:
        return navigateTo(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(
  builder: (context) => widget,
);