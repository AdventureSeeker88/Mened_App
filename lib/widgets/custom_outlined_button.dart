import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final Color borderColor;
  const CustomOutlinedButton({
    Key? key,
    required this.onTap,
    required this.child,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Center(child: child),
      ),
    );
  }
}
