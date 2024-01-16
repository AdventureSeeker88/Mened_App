import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/widgets/custom_elevated_button.dart';

class MenderListScreen extends StatefulWidget {
  const MenderListScreen({Key? key}) : super(key: key);

  @override
  State<MenderListScreen> createState() => _MenderListScreenState();
}

class _MenderListScreenState extends State<MenderListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
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
                          // Navigator.pop(context);

                          context.pop();
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
              StreamBuilder<List<AuthM>>(
                  stream: filterMendors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final mendorData = snapshot.data!;
                      return mendorData.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 100 * 15,
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/png/no_mender.png",
                                    height: 350,
                                    // width: 250,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 100 * 1,
                                ),
                                const Text(
                                  "There isn't any mender available.",
                                  style: TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "dripping",
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: mendorData.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: themewhitecolor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              (mendorData[index].image != "")
                                                  ? mendorData[index].image
                                                  : "https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=1200:*",
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mendorData[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  mendorData[index].bio,
                                                  // "Licensed Professional Counselor PHD, LPC",
                                                  style: const TextStyle(
                                                    color:
                                                        themelightgreenshade2color,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Row(
                                      //   children:  [
                                      //     Icon(
                                      //       Icons.star,
                                      //       color: themeyellowcolor,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     Text(

                                      //       "4.5 (1245)",
                                      //       style: TextStyle(
                                      //         color: themegreytextcolor,
                                      //         fontSize: 12,
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${mendorData[index].chargeCoins} Token/Minute",
                                            style: const TextStyle(
                                              color: themegreytextcolor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            onTap: () {
                                              Go.named(context,
                                                  Routes.chattingScreen, {
                                                'id': mendorData[index].uid,
                                              });
                                            },
                                            buttonSize: const Size(100, 35),
                                            buttoncolor: themelightgreencolor
                                                .withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            elevation: 5,
                                            child: const Text(
                                              "Contact",
                                              style: TextStyle(
                                                  color: themewhitecolor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                            );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // mendors list Screen subject
  Stream<List<AuthM>> filterMendors() => FirebaseFirestore.instance
      .collection('auth')
      .where('type', isEqualTo: 1)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => AuthM.fromJson(document.data()))
          .toList());

  Future<Object?> connectingWithMender(size) {
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
          title: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "Connecting with the mender",
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
          ),
        ),
      ),
    );
  }

  Future<Object?> rateYourMender(context) {
    final size = MediaQuery.of(context).size;
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
          title: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "Rate your Mender",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text.rich(
                      TextSpan(
                        text:
                            "How would you rate communication between you and ",
                        style: TextStyle(
                          color: themegreytextcolor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Dr. Kathryn",
                            style: TextStyle(
                              color: themeblackcolor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star_border,
                          color: themegreytextcolor,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          buttonText: "Skip",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          textstyle: const TextStyle(
                            color: themegreytextcolor,
                            fontSize: 16,
                          ),
                        ),
                        CustomElevatedButton(
                          onTap: () {},
                          buttonSize: const Size(100, 35),
                          buttoncolor: themelightgreencolor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
