import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';

class SettingsPrivacyScreen extends StatefulWidget {
  const SettingsPrivacyScreen({Key? key}) : super(key: key);

  @override
  State<SettingsPrivacyScreen> createState() => _SettingsPrivacyScreenState();
}

class _SettingsPrivacyScreenState extends State<SettingsPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomIconButton(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: themewhitecolor,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Settings and Privacy",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Account",
                  style: TextStyle(
                    color: themegreycolor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: themelightgreenshade2color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    itemCount: 4,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (index == 0) {
                            context.pushNamed(
                              Routes.mendedAccount,
                            );
                          } else if (index == 1) {
                            context.pushNamed(
                              Routes.privacyPolicy,
                            );
                          } else if (index == 2) {
                            context.pushNamed(
                              Routes.changePassword,
                            );
                          } else if (index == 3) {
                            context.pushNamed(
                              Routes.shareProfile,
                            );
                          }
                        },
                        title: Text(
                          index == 0
                              ? "Account"
                              : index == 1
                                  ? "Privacy"
                                  : index == 2
                                      ? "Security"
                                      : "Share Profile",
                          style: const TextStyle(
                            color: themewhitecolor,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: themewhitecolor,
                          size: 18,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: themewhitecolor,
                        height: 0,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Content",
                  style: TextStyle(
                    color: themegreycolor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: themelightgreenshade2color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    itemCount: 5,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (index == 1) {
                            context.pushNamed(
                              Routes.contentPreferences,
                            );
                          }
                        },
                        title: Text(
                          index == 0
                              ? "Comment History"
                              : index == 1
                                  ? "Content Preferences"
                                  : index == 2
                                      ? "Advertisements"
                                      : index == 3
                                          ? "Display"
                                          : "Screen time",
                          style: const TextStyle(
                            color: themewhitecolor,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: themewhitecolor,
                          size: 18,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: themewhitecolor,
                        height: 0,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Help and information",
                  style: TextStyle(
                    color: themegreycolor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: themelightgreenshade2color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    itemCount: 4,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (index == 0) {
                            context.pushNamed(
                              Routes.reportProblem,
                            );
                          } else if (index == 1) {
                            context.pushNamed(
                              Routes.mendedHelp,
                            );
                          } else if (index == 2) {
                            context.pushNamed(
                              Routes.termsConditions,
                            );
                          } else {
                            FirebaseAuth.instance.signOut();
                            context.pushNamed(
                              Routes.splash,
                            );
                          }
                        },
                        title: Text(
                          index == 0
                              ? "Report a problem"
                              : index == 1
                                  ? "Help"
                                  : index == 2
                                      ? "Terms and conditions"
                                      : "Logout",
                          style: const TextStyle(
                            color: themewhitecolor,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: themewhitecolor,
                          size: 18,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: themewhitecolor,
                        height: 0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
