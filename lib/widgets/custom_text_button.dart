import 'package:flutter/cupertino.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final TextStyle textstyle;
  const CustomTextButton(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      required this.textstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        buttonText,
        style: textstyle,
      ),
    );
  }
}
