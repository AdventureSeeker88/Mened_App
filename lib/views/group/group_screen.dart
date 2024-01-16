import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/model/group_model.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          context.pushNamed(
            'create-group',
          );
        },
        child: Image.asset("assets/images/png/mended-add-reel.png"),
      ),
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Support Groups",
                    style: TextStyle(
                      color: themewhitecolor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: "dripping",
                    ),
                  ),
                ),
                StreamBuilder<List<GroupModel>>(
                    stream: streamGroup(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final groupsData = snapshot.data!;
                        return groupsData.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height / 100 * 15,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      "assets/images/png/no_group.png",
                                      height: 350,
                                      // width: 250,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 100 * 1,
                                  ),
                                  const Text(
                                    "No Groups Available",
                                    style: TextStyle(
                                      color: themewhitecolor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "dripping",
                                    ),
                                  ),
                                ],
                              )
                            : GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: groupsData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  mainAxisExtent: 230,
                                ),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: themewhitecolor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CircleAvatar(
                                              radius: 35,
                                              backgroundColor:
                                                  Palette.themecolor,
                                              backgroundImage: NetworkImage(
                                                groupsData[index].image,
                                              )),
                                          Text(
                                            groupsData[index].title,
                                            style: const TextStyle(
                                              color: themegreencolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                (groupsData[index].type ==
                                                        "Public")
                                                    ? Icons.lock_open
                                                    : Icons.lock,
                                                color: themegreytextcolor,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                groupsData[index].type,
                                                style: const TextStyle(
                                                  color: themegreytextcolor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.people_outline,
                                                color: themegreytextcolor,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                "${groupsData[index].member.length} Members",
                                                style: const TextStyle(
                                                  color: themegreytextcolor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          (groupsData[index].member.contains(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid))
                                              ? CustomTextButton(
                                                  buttonText: "View Group",
                                                  onTap: () {
                                                    Go.named(context,
                                                        Routes.groupPost, {
                                                      'id':
                                                          groupsData[index].id,
                                                    });
                                                  },
                                                  textstyle: const TextStyle(
                                                    color: themelightgreencolor,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "dripping",
                                                  ),
                                                )
                                              : CustomTextButton(
                                                  buttonText: "Join Group",
                                                  onTap: () {
                                                    connectingtoSupportGroup(
                                                      size,
                                                      supportgroupmodels[index]
                                                          .title,
                                                      groupsData[index].id,
                                                    );
                                                  },
                                                  textstyle: const TextStyle(
                                                    color: themelightgreencolor,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "dripping",
                                                  ),
                                                ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> connectingtoSupportGroup(size, title, id) {
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
            title: LoadingWidget(title: title, id: id)),
      ),
    );
  }

  Stream<List<GroupModel>> streamGroup() => FirebaseFirestore.instance
      .collection(Database.group)
      .where('status', isEqualTo: 0)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => GroupModel.fromJson(document.data()))
          .toList());
}

class SupportGroupModels {
  final String image;
  final String title;
  SupportGroupModels({
    required this.image,
    required this.title,
  });
}

List<SupportGroupModels> supportgroupmodels = [
  SupportGroupModels(
    image: "assets/images/png/hand-1.png",
    title: "Anxiety",
  ),
  SupportGroupModels(
    image: "assets/images/png/hand-2.png",
    title: "Single Dad",
  ),
  SupportGroupModels(
    image: "assets/images/png/hand-3.png",
    title: "School",
  ),
  SupportGroupModels(
    image: "assets/images/png/hand-4.png",
    title: "Soccer",
  ),
  SupportGroupModels(
    image: "assets/images/png/hand-5.png",
    title: "Sad Day",
  ),
  SupportGroupModels(
    image: "assets/images/png/hand-6.png",
    title: "John's Hopkins",
  ),
];

class LoadingWidget extends StatefulWidget {
  final String title;
  final String id;
  const LoadingWidget({super.key, required this.title, required this.id});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 3),
      () {
        final groupProvider = Provider.of<GroupPro>(context, listen: false);
        groupProvider.groupJoinFun(widget.id, context);
        Navigator.pop(context);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Column(
            children: [
              Text(
                "Connecting to the ${widget.title} Support Group",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: themeblackcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please wait for a mender to approve your session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themegreytextcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: themelightgreenshade2color,
                backgroundColor: themelightgreencolor,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextButton(
                buttonText: "Cancel",
                onTap: () {
                  timer!.cancel();
                  Navigator.pop(context);
                },
                textstyle: const TextStyle(
                  color: themegreytextcolor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
