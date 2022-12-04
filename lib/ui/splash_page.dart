import 'package:flutter/material.dart';
import 'package:task/auth/phone_auth.dart';
import 'package:task/data/local_storage/storage.dart';
import 'package:task/ui/my_home_page.dart';
import 'package:task/utils/icons/icon.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  bool isValid = false;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await StorageRepository.getInstance();
    print("booooooooollllllllllllll  ${widget.isValid}");
    widget.isValid = StorageRepository.getBool("isValid");
    Future.delayed(const Duration(seconds: 2)).then((value) {
      print("bool  ${widget.isValid}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.isValid ? const MyHomePage() : const PhoneAuth(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(MyIcons.appLogo),
      ),
    );
  }
}
