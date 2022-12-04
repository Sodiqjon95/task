import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key, required this.title, required this.onTap,}) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        minimumSize: MaterialStateProperty.all(
          const Size(250, 50),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.blue,
        ),
      ),
      onPressed: onTap,


      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }
}
