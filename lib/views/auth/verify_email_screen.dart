import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/path.dart';
import 'package:mended/views/splash/splash_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Catch Exception: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isEmailVerified
      ? const SplashScreen()
      : WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: themelightgreencolor,
            body: Stack(
              children: [
                Image.asset(
                  Assets.greenBackground,
                  fit: BoxFit.cover,
                  width: size.width,
                  // height: size.height,
                ),
                SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/png/bkgrnd-img.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Verify Email",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: themewhitecolor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "A Verification email has been sent to your email.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: themewhitecolor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: themewhitecolor,
                                        minimumSize: const Size.fromHeight(40),
                                        elevation: 5),
                                    onPressed: () {
                                      sendVerificationEmail();
                                    },
                                    icon: const Icon(
                                      Icons.email,
                                      size: 28,
                                      color: themegreencolor,
                                    ),
                                    label:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Resent Email".toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: themegreencolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(80),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 24, color: themewhitecolor),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
