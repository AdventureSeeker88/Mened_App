import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/service/notification_service.dart';
import 'package:mended/theme/colors.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  NotificationServices notificationServices = NotificationServices();
  late StreamSubscription subscription;

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    WidgetsBinding.instance.addObserver(this);
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    final post = Provider.of<AuthPro>(context, listen: false);
    await setStatus(true);
    await post.getmyData();
    Timer(const Duration(seconds: 3), () async {
      FirebaseAuth.instance.idTokenChanges();
      notificationServices.getDeviceToken().then((value) async {
        await post.updatetoken(value);
      });

      Go.namedreplace(context, Routes.navbar);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus(true);
    } else {
      setStatus(false);
    }
  }

  setStatus(bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection("auth")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'onlineStatus': status ? "online" : "offline"});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/png/fondo.png",
            fit: BoxFit.cover,
            width: size.width,
            // height: size.height,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: themewhitecolor.withOpacity(0.5),
                  child: Image.asset(
                    "assets/images/png/mended-logo.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Mended",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
