import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';

import 'founded_member_bottom_sheet.dart';

class FindMendorBottomSheet extends StatefulWidget {
  const FindMendorBottomSheet({super.key});

  @override
  State<FindMendorBottomSheet> createState() => _FindMendorBottomSheetState();
}

class _FindMendorBottomSheetState extends State<FindMendorBottomSheet> {
  int selectedValue = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController sessionQueryC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 100 * 75,
      decoration: BoxDecoration(
        color: themegreencolor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            themelightgreencolor.withOpacity(0.2),
            themelightgreencolor.withOpacity(0.4),
            themegreencolor.withOpacity(0.6),
            themegreencolor.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.4, 0.8, 1],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Find Mender",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: themewhitecolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "How many minutes you want to take therapy session?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return InkWell(
                        onTap: () {
                          log("Selected Index $index");
                          setState(() {
                            selectedValue = index;
                          });
                          log("SelectedDuration: ${selectedValue == 0 ? "10" : selectedValue == 1 ? "30" : selectedValue == 2 ? "45" : selectedValue == 3 ? "Ongoing" : ""}");
                        },
                        child: Container(
                          height: 70,
                          width: size.width / 100 * 18,
                          decoration: BoxDecoration(
                            color: selectedValue == index
                                ? themegreycolor
                                : themelightgreenshade2color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                index == 0
                                    ? "10"
                                    : index == 1
                                        ? "30"
                                        : index == 2
                                            ? "45"
                                            : "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: themelightgreencolor,
                                  fontSize: index == 3 ? 0 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                index == 3 ? "Ongoing" : "min",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: themelightgreencolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "What do you need to cover this session",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    maxLines: 4,
                    controller: sessionQueryC,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: themewhitecolor,
                      border: OutlineInputBorder(
                         borderSide: const BorderSide(
                          color: themegreytextcolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "What would you like to discuss...",
                      hintStyle: const TextStyle(color: themegreytextcolor)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please write something to continue.";
                      }

                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomIconButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    connectingWithMender(
                        size, context, selectedValue, sessionQueryC.text);
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/png/mended-button-small.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Object?> connectingWithMender(size, context, selectedValue, detail) {
  return showAnimatedDialog(
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 700),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          titlePadding: const EdgeInsets.all(24),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: FindMenderLoad(
            selectedValue: selectedValue,
            detail: detail,
          )),
    ),
  );
}

class FindMenderLoad extends StatefulWidget {
  final int selectedValue;
  final String detail;
  const FindMenderLoad(
      {super.key, required this.selectedValue, required this.detail});

  @override
  State<FindMenderLoad> createState() => _FindMenderLoadState();
}

class _FindMenderLoadState extends State<FindMenderLoad> {
  Timer? timer;
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);
      showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => FoundedMemberBottomSheet(
            duration: widget.selectedValue == 0
                ? 5
                : widget.selectedValue == 1
                    ? 30
                    : widget.selectedValue == 2
                        ? 45
                        : 0,
            message: widget.detail,
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Column(
            children: [
              const Text(
                "Connecting with the Mender",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeblackcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please wait for a mender to approve your session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themegreytextcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: themelightgreenshade2color,
                backgroundColor: themelightgreencolor,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextButton(
                buttonText: "Cancel",
                onTap: () {
                  timer!.cancel();
                  Navigator.pop(context);
                },
                textstyle: const TextStyle(
                  color: themegreytextcolor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
