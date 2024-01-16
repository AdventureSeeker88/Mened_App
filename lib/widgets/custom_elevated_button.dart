import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Size buttonSize;
  final Color buttoncolor;
  final BorderRadius borderRadius;
  final double elevation;
  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.buttonSize,
    required this.buttoncolor,
    required this.borderRadius,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttoncolor,
        elevation: elevation,
        minimumSize: buttonSize,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
