import 'package:flutter/cupertino.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const CustomIconButton({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: child);
  }
}
