import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/auth/login_screen.dart';
import 'package:mended/views/auth/verify_email_screen.dart';
import 'package:mended/views/onboarding/onboardingscreen.dart';
import 'package:mended/views/splash/splash_screen.dart';

class SplashService extends StatefulWidget {
  const SplashService({super.key});

  @override
  State<SplashService> createState() => _SplashServiceState();
}

class _SplashServiceState extends State<SplashService> {
 

  @override
  Widget build(BuildContext context) {
    return 
    // Scaffold(
    //   backgroundColor: themewhitecolor,
    //   // body: FirebaseAuth.instance.currentUser == null
    //   //             ? const LoginScreen()
    //   //             : const SplashScreen(),
    //   // body: SafeArea(
    //   //   child: StreamBuilder(
    //   //     stream: FirebaseAuth.instance.authStateChanges(),
    //   //     builder: (context, snapshot) {
    //   //       if (snapshot.hasData) {
    //   //         return const VerifyEmailScreen();
    //   //       } else {
    //   //         return FirebaseAuth.instance.currentUser == null
    //   //             ? const LoginScreen()
    //   //             : const SplashScreen();
    //   //       }
    //   //     },
    //   //   ),
    //   // ),
    //   // body: SafeArea(
    //   //   child: StreamBuilder(
    //   //     stream: FirebaseAuth.instance.authStateChanges(),
    //   //     builder: (context, snapshot) {
    //   //       if (snapshot.hasData) {
    //   //         return const VerifyEmailScreen();
    //   //       } else {
    //   //         return FirebaseAuth.instance.currentUser == null
    //   //             ? const LoginScreen()
    //   //             : const SplashScreen();
    //   //       }
    //   //     },
    //   //   ),
    //   // ),
    // );
    StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailScreen();
            } else {
              return FirebaseAuth.instance.currentUser == null
                  ? const LoginScreen()
                  : const SplashScreen();
            }
          },
        );
  }
}
