import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mended/theme/colors.dart';

class CustomTimer extends StatefulWidget {
  final dynamic onSecond;
  final dynamic onMinute;
  final dynamic onHour;
  final dynamic onComplete;
  final int hour;
  final int minute;
  final int seconds;
  final TextStyle textStyle;
  const CustomTimer(
      {super.key,
      this.onSecond,
      this.onMinute,
      this.onHour,
      this.onComplete,
      this.hour = 0,
      this.minute = 0,
      this.seconds = 0,
      this.textStyle = const TextStyle()});

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int hour = 0;
  int minute = 0;
  int seconds = 1;
  Timer? timer;
  bool textColor = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  init() async {
    log(widget.hour.toString());
    log(widget.minute.toString());
    log(widget.seconds.toString());

    widget.onMinute();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (widget.hour == 0 && widget.minute == 0 && widget.seconds == 0) {
        load();
      } else {
        if (widget.hour == hour &&
            widget.minute == minute &&
            widget.seconds == seconds) {
          setState(() {
            textColor = true;
          });
          widget.onComplete();
        } else {
          load();
        }
      }
    });
  }

  load() {
    if (seconds == 59) {
      if (minute == 60) {
        setState(() {
          minute = 0;
          hour += 1;
          seconds = 0;
        });
        widget.onHour();
      } else {
        setState(() {
          minute += 1;
          seconds = 0;
        });
        widget.onMinute();
      }
    } else {
      setState(() {
        seconds += 1;
      });

      widget.onSecond();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${hour.toString().padLeft(2, '0')}: ${minute.toString().padLeft(2, '0')}: ${seconds.toString().padLeft(2, '0')}',
      style: TextStyle(
        color: textColor ? themegreencolor : themewhitecolor,
      ),
    );
  }
}
