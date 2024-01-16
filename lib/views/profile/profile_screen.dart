import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/future/future.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/views/profile/tabs/all_posts_tab.dart';
import 'package:mended/views/profile/tabs/calender_tab.dart';
import 'package:mended/views/profile/tabs/mended_fav_post_tab.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Go.named(context, Routes.addflick);
        },
        child: Image.asset("assets/images/png/mended-add-reel.png"),
      ),
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: StreamBuilder<AuthM>(
            stream: filterUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;
                return userData.email.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Image.asset(
                          "assets/images/png/mender-circular-logo.png",
                        )),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomIconButton(
                                  onTap: () {
                                    context.pushNamed(
                                      'view-notifications',
                                    );
                                  },
                                  child: const Icon(
                                    Icons.notifications,
                                    color: themeyellowcolor,
                                  ),
                                ),
                                const Spacer(),
                                // CustomIconButton(
                                //    onTap: () {
                                //     FirebaseAuth.instance.signOut();
                                //      context.pushNamed(
                                //       Routes.splash,
                                //     );
                                //   },
                                //   child: const Icon(
                                //     Icons.logout_outlined,
                                //     color: themewhitecolor,
                                //   ),
                                // ),
                                // CustomSimpleRoundedButton(
                                //   onTap: () {
                                // FirebaseAuth.instance.signOut();
                                // context.pushNamed(
                                //   Routes.splash,
                                // );
                                //   },
                                //   height: 30,
                                //   width: 100,
                                //   buttoncolor: themewhitecolor,
                                //   borderRadius: BorderRadius.circular(10),
                                //   child: Text(
                                //     "Logout",
                                //     style: TextStyle(
                                //       color: themegreencolor,
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                CustomTextButton(
                                  buttonText: "Settings",
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.viewAccountSettings,
                                    );
                                  },
                                  textstyle: const TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (userData.image != "") {}
                            },
                            child: Hero(
                                tag: "profile-img",
                                child: CustomCircleAvtar(
                                  url: userData.image,
                                  height: 80,
                                  width: 80,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            userData.name,
                            style: const TextStyle(
                              color: themewhitecolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData.bio,
                            style: const TextStyle(
                              color: themegreytextcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomSimpleRoundedButton(
                                onTap: () {},
                                height: 60,
                                width: width / 100 * 40,
                                buttoncolor: themelightgreencolor,
                                borderRadius: BorderRadius.circular(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<int>(
                                        future: FutureFun().flickTotalViews(
                                            FirebaseAuth
                                                .instance.currentUser!.uid),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            int get = snapshot.data!;
                                            return Text(
                                              get.toString(),
                                              style: const TextStyle(
                                                color: themewhitecolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return const Text("0",
                                                style: TextStyle(
                                                  color: themewhitecolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ));
                                          }
                                        }),
                                    const Text(
                                      "views",
                                      style: TextStyle(
                                        color: themegreycolor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomSimpleRoundedButton(
                                onTap: () {},
                                height: 60,
                                width: width / 100 * 40,
                                buttoncolor: themelightgreencolor,
                                borderRadius: BorderRadius.circular(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userData.supporterList.length.toString(),
                                      style: const TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "supporters",
                                      style: TextStyle(
                                        color: themegreycolor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomIconButton(
                                  onTap: () {
                                    // RouteNavigator.route(
                                    //   context,
                                    //   const BuddyListScreen(),
                                    // );

                                    Go.named(context, Routes.buddyList);
                                  },
                                  child:  Column(
                                    children: [
                                      Icon(
                                        Icons.people_alt_outlined,
                                        color: themewhitecolor,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Buddy List",
                                        style: TextStyle(
                                          color: themewhitecolor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  color: themewhitecolor,
                                ),
                                CustomIconButton(
                                  onTap: () {
                                    Go.named(context, Routes.menderList);
                                  },
                                  child:  Column(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: themewhitecolor,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Mender List",
                                        style: TextStyle(
                                          color: themewhitecolor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  color: themewhitecolor,
                                ),
                                CustomIconButton(
                                  onTap: () {
                                    Go.named(context, Routes.messagesScreen);
                                  },
                                  child:  Column(
                                    children: [
                                      Icon(
                                        Icons.bubble_chart_outlined,
                                        color: themewhitecolor,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Messages",
                                        style: TextStyle(
                                          color: themewhitecolor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            color: themelightgreencolor,
                            child: TabBar(
                              controller: tabController,
                              indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide.none,
                              ),
                              labelColor: themewhitecolor,
                              unselectedLabelColor: themeblackcolor,
                              tabs: const [
                                Tab(
                                  icon: Icon(
                                    Icons.tag,
                                    size: 30,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                AllPostsTab(
                                  isMainProfile: true,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                ),
                                const MendedFavPostTab(),
                                const CalenderTab(),
                              ],
                            ),
                          ),
                        ],
                      );
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  Stream<AuthM> filterUser(String uid) {
    return FirebaseFirestore.instance
        .collection(Database.auth)
        .doc(uid)
        .snapshots()
        .map((snapshot) => AuthM.fromJson(snapshot.data() ?? {}));
  }
}
