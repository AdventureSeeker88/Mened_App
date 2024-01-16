import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/widgets/custom_elevated_button.dart';

class BuddiesCategoryScreen extends StatefulWidget {
  const BuddiesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<BuddiesCategoryScreen> createState() => _BuddiesCategoryScreenState();
}

class _BuddiesCategoryScreenState extends State<BuddiesCategoryScreen> {
 

  @override
  Widget build(BuildContext context) {
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
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.search,
                        color: themewhitecolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Select a category",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: themewhitecolor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView.separated(
                          itemCount: findbuddymodel.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: themelightgreenshade2color,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    findbuddymodel[index].image,
                                  ),
                                ),
                              ),
                              title: Text(
                                findbuddymodel[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: CustomSimpleRoundedButton(
                                onTap: () {
                                  Go.named(context, Routes.buddyConnecting, {
                                    'category': findbuddymodel[index].title,
                                  });
                                },
                                height: 40,
                                width: 120,
                                buttoncolor:
                                    themelightgreenshade2color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25.0),
                                child: const Text(
                                  "Find Buddy",
                                  style: TextStyle(
                                    color: themelightgreencolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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

class FindBuddyModel {
  final String image;
  final String title;
  FindBuddyModel({
    required this.image,
    required this.title,
  });
}

List<FindBuddyModel> findbuddymodel = [
  FindBuddyModel(
    image: "assets/images/svg/college-life.svg",
    title: "College Life",
  ),
  FindBuddyModel(
    image: "assets/images/svg/depression.svg",
    title: "Depression",
  ),
  FindBuddyModel(
    image: "assets/images/svg/anxiety.svg",
    title: "Anxiety",
  ),
  FindBuddyModel(
    image: "assets/images/svg/military.svg",
    title: "Military",
  ),
  FindBuddyModel(
    image: "assets/images/svg/single-mom.svg",
    title: "Single mom",
  ),
  FindBuddyModel(
    image: "assets/images/svg/single-dad.svg",
    title: "Single dad",
  ),
  FindBuddyModel(
    image: "assets/images/svg/heart-break.svg",
    title: "Heartbreak",
  ),
  FindBuddyModel(
    image: "assets/images/svg/business.svg",
    title: "Business",
  ),
  FindBuddyModel(
    image: "assets/images/svg/stressed.svg",
    title: "Stressed",
  ),
  FindBuddyModel(
    image: "assets/images/svg/sports.svg",
    title: "Sports",
  ),
  FindBuddyModel(
    image: "assets/images/svg/other.svg",
    title: "Other",
  ),
];
