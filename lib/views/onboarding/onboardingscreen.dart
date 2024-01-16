import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/png/fondo.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      currentIndex = page;
                      print(page);
                    });
                  },
                  controller: _pageController,
                  children: const [
                    CreatePage(
                      image: 'assets/images/png/onboard-1.png',
                      title: "Find Menders",
                      desc:
                          "This app will help you to find the help that you need. You can look for a mender in the list and have video sessions",
                      color: themewhitecolor,
                    ),
                    CreatePage(
                      image: 'assets/images/png/onboard-3.png',
                      title: "Support Group",
                      desc:
                          "You will have access to support group to share experiences and see the experiences of others.",
                      color: themewhitecolor,
                    ),
                    CreatePage(
                      image: 'assets/images/png/onboard-2.png',
                      title: "Find Buddies",
                      desc:
                          "You can also search buddies and connect with them to share experience.",
                      color: themewhitecolor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 150, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicator(),
                  ),
                ),
                currentIndex == 2
                    ? Positioned(
                        bottom: 20,
                        child: InkWell(
                          onTap: () {
                            Go.namedreplace(context, Routes.splash);
                          },
                          child: Container(
                            height: 60,
                            width: size.width / 100 * 70,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/png/mended-button.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Positioned(
                        right: 30,
                        bottom: 30,
                        left: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextButton(
                              buttonText: "Skip",
                              onTap: () {
                                Go.named(context, Routes.splash);
                              },
                              textstyle: const TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (currentIndex == 0) {
                                    _pageController.jumpToPage(1);
                                  } else if (currentIndex == 1) {
                                    _pageController.jumpToPage(2);
                                  } else if (currentIndex == 2) {
                                    _pageController.jumpToPage(3);
                                  } else if (currentIndex == 3) {}
                                });
                              },
                              child: Row(
                                children: [
                                  currentIndex == 2
                                      ? Container(
                                          height: 60,
                                          width: size.width,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/png/mended-button.png",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: themewhitecolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      : CustomIconButton(
                                          onTap: () {
                                            setState(() {
                                              if (currentIndex == 0) {
                                                _pageController.jumpToPage(1);
                                              } else if (currentIndex == 1) {
                                                _pageController.jumpToPage(2);
                                              } else if (currentIndex == 2) {
                                                _pageController.jumpToPage(3);
                                              } else if (currentIndex == 3) {}
                                            });
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 150,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/png/mended-button-small-n.png",
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
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _activeindicator(bool isActive) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 14.0,
      width: width / 100 * 5,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: currentIndex == 0
            ? themewhitecolor
            : currentIndex == 1
                ? themewhitecolor
                : currentIndex == 2
                    ? themewhitecolor
                    : currentIndex == 3
                        ? themewhitecolor
                        : null,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _inactiveindicator(bool isInActive) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 14.0,
      width: width / 100 * 6,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        // color: themegreycolor,
        shape: BoxShape.circle,
        border: Border.all(
          color: themewhitecolor,
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_activeindicator(true));
      } else {
        indicators.add(_inactiveindicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final Color color;

  const CreatePage({
    Key? key,
    required this.image,
    required this.title,
    required this.desc,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          image,
          width: width,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: themegreycolor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // RouteNavigator.replacementroute(context, GetStartedScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/png/ke-dual-logo.png",
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themegreycolor.withOpacity(0.3),
                themegreycolor.withOpacity(0.4),
                themeblackcolor.withOpacity(0.6),
                themeblackcolor.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.4, 0.8, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "خوش آمدید",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "کشمیر ایکسپریس نیوز",
                  style: TextStyle(
                      color: themewhitecolor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "اب خبروں تک ہوئی رسائی اور بھی آسان ،صرف ایک کلک پر دنیا بھر کی تازہ ترین صورتحال سے باخبر رہیں",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
