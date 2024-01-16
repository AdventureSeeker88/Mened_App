import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/group/group_screen.dart';
import 'package:mended/views/memeland/memeland_screen.dart';
import 'package:mended/views/mender/bottomsheet/find_mender_bottom_sheet.dart';
import 'package:mended/views/profile/profile_screen.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(
      //   width: width / 100 * 60,
      //   child: MainDrawer(),
      // ),
      floatingActionButton: CustomIconButton(
        onTap: () {
          // FirebaseAuth.instance.signOut();
          chooseOption(size);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CircleAvatar(
            radius: 34,
            backgroundColor: themewhitecolor.withOpacity(0.5),
            child: Image.asset(
              "assets/images/png/mended-logo.png",
              height: 58,
              width: 58,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 120,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/png/bottom-nav-bar.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  _currentIndex == 0
                      ? "assets/images/png/home-selected.png"
                      : "assets/images/png/home-icon.png",
                  width: 50,
                  height: 35,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  _currentIndex == 1
                      ? "assets/images/png/people-selected.png"
                      : "assets/images/png/people-icon.png",
                  width: 50,
                  height: 35,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  _currentIndex == 2
                      ? "assets/images/png/person-selected.png"
                      : "assets/images/png/person-icon.png",
                  width: 50,
                  height: 35,
                ),
              ),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: navigationTapped,
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          MemelandScreen(),
          // Container(),
          GroupScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }

  Future<Object?> chooseOption(size) {
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
                const Text(
                  "What do you want to find?",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: themegreencolor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                          ),
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: const FindMendorBottomSheet(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: size.width / 100 * 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/png/mended-button-small.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people,
                              color: themewhitecolor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Mender",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Go.named(context, Routes.buddyCategory);
                      },
                      child: Container(
                        height: 60,
                        width: size.width / 100 * 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/png/mended-button-small.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: themewhitecolor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Buddies",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
}
