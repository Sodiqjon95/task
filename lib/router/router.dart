import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/otp.dart';
import 'package:task/ui/card/my_card.dart';
import 'package:task/ui/map_route/map_route.dart';
import 'package:task/ui/my_home_page.dart';
import 'package:task/ui/payment_page.dart';
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

        case RouteNames.payment:
        return navigateTo(PaymentPage(bookSalary: settings.arguments as double,));

        case RouteNames.myCards:
        return navigateTo(MyCards());

        case RouteNames.mapRoute:
        return navigateTo(MapRoute());
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