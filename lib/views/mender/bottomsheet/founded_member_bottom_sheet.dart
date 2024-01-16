import 'dart:developer';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/call_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/chat/Future/future.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/toast.dart';
import 'package:provider/provider.dart';

class FoundedMemberBottomSheet extends StatefulWidget {
  int duration;
  String message;

  FoundedMemberBottomSheet({
    super.key,
    required this.duration,
    required this.message,
  });

  @override
  State<FoundedMemberBottomSheet> createState() =>
      _FoundedMemberBottomSheetState();
}

class _FoundedMemberBottomSheetState extends State<FoundedMemberBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: SizedBox(
        // height: size.height / 100 * 80,
        child: Scaffold(
          backgroundColor: themegreencolor,
          body: Container(
            decoration: BoxDecoration(
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
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
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
                  StreamBuilder<List<AuthM>>(
                      stream: get_random_mender(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: themelightgreenshade2color,
                            backgroundColor: themelightgreencolor,
                          );
                        } else {
                          if (snapshot.hasError) {
                            return Text(
                                'Something went wrong! ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final menderData = snapshot.data!;

                            return menderData.isEmpty
                                ? Expanded(
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/png/mended-logo.png",
                                    )),
                                  )
                                : Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 80,
                                            ),
                                            child: Container(
                                              height: size.height / 100 * 46,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: themewhitecolor,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                            
                                              children: [
                                                Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        (menderData[0].image !=
                                                                "")
                                                            ? menderData[0]
                                                                .image
                                                            : "https://cdn.theatlantic.com/thumbor/vDZCdxF7pRXmZIc5vpB4pFrWHKs=/559x0:2259x1700/1080x1080/media/img/mt/2017/06/shutterstock_319985324/original.jpg",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  menderData[0].name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  menderData[0].bio,
                                                  style: const TextStyle(
                                                    color: themelightgreencolor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Divider(
                                                  color: themelightgreencolor,
                                                  height: 40,
                                                  indent: 60,
                                                  endIndent: 60,
                                                ),
                                                const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40.0),
                                                    child: Text(
                                                      "About Doctor",
                                                      style: TextStyle(
                                                        color:
                                                            themegreytextcolor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                 Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 40.0),
                                                  child: Flexible(
                                                    child: Text(
                                                     menderData[0].aboutDoctor,
                                                   
                                                    maxLines: 3,overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: themegreytextcolor,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: themelightgreencolor,
                                                  height: 40,
                                                  indent: 60,
                                                  endIndent: 60,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: themeyellowcolor,
                                                      size: 20,
                                                    ),
                                                    const Text(
                                                      "4.5(1245)",
                                                      style: TextStyle(
                                                        color:
                                                            themegreytextcolor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Text(
                                                      "${menderData[0].chargeCoins} Coins/Minute",
                                                      style: const TextStyle(
                                                        color:
                                                            themegreytextcolor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color:
                                              themegreycolor.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                                color: themeblackcolor
                                                    .withOpacity(0.4),
                                                blurRadius: 10,
                                                offset: const Offset(5, 10)),
                                          ],
                                        ),
                                        child: Text(
                                          // "00:29",
                                          widget.duration == 0
                                              ? "${menderData[0].chargeCoins} Coins/Minute"
                                              : "Duration ${widget.duration} Minutes, ${menderData[0].chargeCoins * widget.duration} Coins will be Charged",
                                          style: const TextStyle(
                                            color: themewhitecolor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomSimpleRoundedButton(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            height: 50,
                                            width: size.width / 100 * 30,
                                            buttoncolor: themelightgreencolor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: const Text(
                                              "Pick Another",
                                              style: TextStyle(
                                                color: themewhitecolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          FutureBuilder<int>(
                                              future: user_coins_get(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  int coins = snapshot.data!;
                                                  return coins == 0
                                                      ? CustomSimpleRoundedButton(
                                                          onTap: () {
                                                            log("Coins:**********************");
                                                            log("coins:$coins");
                                                            customToast(
                                                                "Please Recharge to make calls.",
                                                                context);
                                                          },
                                                          height: 50,
                                                          width: size.width /
                                                              100 *
                                                              40,
                                                          buttoncolor:
                                                              themewhitecolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: const Text(
                                                            "Don't have enough Coins",
                                                            style: TextStyle(
                                                              color:
                                                                  themelightgreencolor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        )
                                                      : CustomSimpleRoundedButton(
                                                          onTap: () {
                                                            log("Coins: $coins");
                                                            log("${menderData[0].chargeCoins * widget.duration}");
                                                            int totalCoinsDeduction =
                                                                menderData[0]
                                                                        .chargeCoins *
                                                                    widget
                                                                        .duration;
                                                            log("totalCoinsDeduction: $totalCoinsDeduction");
                                                            if (coins <
                                                                totalCoinsDeduction) {
                                                              log("Coins: $coins");
                                                              customToast(
                                                                  "You don't have enough coins to make call.",
                                                                  context);
                                                            } else {
                                                              final callProvider =
                                                                  Provider.of<
                                                                          CallPro>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                              callProvider.createCall(
                                                                  widget
                                                                      .duration,
                                                                  widget
                                                                      .message,
                                                                  totalCoinsDeduction,
                                                                  menderData[0]
                                                                      .uid,
                                                                  context);
                                                            }
                                                          },
                                                          height: 50,
                                                          width: size.width /
                                                              100 *
                                                              30,
                                                          buttoncolor:
                                                              themewhitecolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child: const Text(
                                                            "Start Call",
                                                            style: TextStyle(
                                                              color:
                                                                  themelightgreencolor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        );
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  );
                          } else {
                            return Container();
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//buddy detail filer stream
  Stream<List<AuthM>> get_random_mender() {
    return FirebaseFirestore.instance
        .collection('auth')
        .where('type', isEqualTo: 1)
        .get()
        .then((querySnapshot) {
      final documents = querySnapshot.docs;
      log("documents ${documents.length}");
      if (documents.isEmpty) {
        return <AuthM>[];
      }
      final int randomIndex = math.Random().nextInt(documents.length);
      final selectedDocument = documents[randomIndex];
      final authModel = AuthM.fromJson(selectedDocument.data());

      return <AuthM>[authModel];
    }).asStream();
  }
}
