import 'package:flutter/material.dart';

class CustomImagePickerButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Widget icon;
  final Color color;
  final Color bordercolor;
  final Color textcolor;
  const CustomImagePickerButton(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      required this.icon,
      required this.color,
      required this.bordercolor,
      required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        // padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(10, 6, 10, 6)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: bordercolor),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            buttonText,
            style: TextStyle(
                color: textcolor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
