import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';

class BuddyConnectingScreen extends StatefulWidget {
  final String category;

  const BuddyConnectingScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<BuddyConnectingScreen> createState() => _BuddyConnectingScreenState();
}

class _BuddyConnectingScreenState extends State<BuddyConnectingScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    findbuddy();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void findbuddy() async {
    await FirebaseFirestore.instance
        .collection("auth")
        .where('category', arrayContainsAny: [widget.category])
        .get()
        .then((value) {
          String uid = "uid";
          if (value.docs.isNotEmpty) {
            int randomIndex = math.Random().nextInt(value.docs.length);
            var ramdomaccount = value.docs[randomIndex];
            uid = ramdomaccount.data()['uid'];
          }

          if (uid == FirebaseAuth.instance.currentUser!.uid) {
            findbuddy();
          } else {
            timer = Timer(const Duration(seconds: 2), () {
              log("id: $uid");
              Go.namedreplace(context, Routes.buddyFind, {
                'id': uid,
                'category': widget.category,
              });
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 25.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: themewhitecolor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.people,
                        color: themewhitecolor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Find Buddies",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "Connecting you with a Buddy",
              style: TextStyle(
                color: themewhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.asset("assets/images/png/connecting.png"),
            const Spacer(),
            const Text(
              "Be kind, and be friendly! if you guys don't vibe, then be respectful and go on to the next",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themegreytextcolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.favorite,
                  color: themegreytextcolor,
                ),
                Text(
                  "  Here at mended, we are all family",
                  style: TextStyle(
                    color: themegreytextcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomTextButton(
              buttonText: "Cancel",
              onTap: () {
                timer!.cancel();
                Navigator.pop(context);
              },
              textstyle: const TextStyle(
                color: themewhitecolor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
