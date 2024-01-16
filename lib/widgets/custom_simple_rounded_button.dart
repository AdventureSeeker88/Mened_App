import 'package:flutter/material.dart';

class CustomSimpleRoundedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color buttoncolor;
  final BorderRadius borderRadius;

  const CustomSimpleRoundedButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.height,
    required this.width,
    required this.buttoncolor,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
