import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color buttoncolor;
  final Color buttontextcolor;
  const CustomRoundedButton(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      required this.height,
      required this.width,
      required this.buttoncolor,
      required this.buttontextcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: themeblackcolor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttontextcolor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
