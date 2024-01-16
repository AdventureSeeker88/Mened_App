import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mended/theme/colors.dart';

void showCircularLoadDialog(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) =>
        WillPopScope(onWillPop: () async => true, child: const ProgressDialog()),
  );
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 20,
        color: Palette.themecolor.withOpacity(0.9),
        child: const SizedBox(
          height: 130,
          width: 130,
          child: SpinKitFoldingCube(
            color: themewhitecolor,
          ),
        ),
      ),
    );
  }
}

successfullyDailog(context, content) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 15.0,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.check,
              color: Palette.themecolor,
              size: 40,
            ),
            // Image.asset(
            //   "assets/images/png/phone-verified.png",
            //   height: 80,
            // ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Successfully",
              style: TextStyle(
                  color: Palette.themecolor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    }),
  );
}

errorDailog(context, content) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 15.0,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error,
              color: Palette.themecolor,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Error",
              style: TextStyle(
                  color: Palette.themecolor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    }),
  );
}
