import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Go {
  static route(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static dialogroute(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => screen,
      ),
    );
  }

  static named(BuildContext context, String screen,
      [Map<String, String>? params]) {
   
    context.pushNamed(screen, pathParameters: params ?? {});
  }

  static namedreplace(BuildContext context, String screen,
      [Map<String, String>? params]) {
    context.replaceNamed(
      screen,
      pathParameters: params ?? {},
    );
  }

  static replacementroute(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  static pushandremoveroute(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ),
        (route) => false);
  }
}
