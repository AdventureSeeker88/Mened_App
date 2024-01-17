import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/call_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/views/chat/model/InnerMessageModel.dart';
import 'package:mended/views/chat/pro/ChatPro.dart';
import 'package:mended/views/chat/use_full/id.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:mended/widgets/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class BuddyScreen extends StatefulWidget {
  final String id;
  final String category;
  const BuddyScreen({Key? key, required this.id, required this.category})
      : super(key: key);

  @override
  State<BuddyScreen> createState() => _BuddyScreenState();
}

class _BuddyScreenState extends State<BuddyScreen> {
  TextEditingController _msg_controller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthPro>(context);
    // _authModel.get_blockList.add(FirebaseAuth.instance.currentUser!.uid);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: StreamBuilder<List<AuthM>>(
          stream: getBuddyById(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;

              return userData.isEmpty
                  ? SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25.0),
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
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/png/no_buddy.png",
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Buddy Not Found",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: themewhitecolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Spacer(),
                          ],
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25.0),
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
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Go.namedreplace(
                                          context, Routes.buddyConnecting, {
                                        'category': widget.category,
                                      });
                                    },
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  CustomCircleAvtar(
                                    url: userData[0].image,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    userData[0].name,
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
                                    userData[0].category[0],
                                    style: const TextStyle(
                                      color: themegreytextcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Consumer<AuthPro>(builder:
                                            ((context, modelValue, child) {
                                          return modelValue
                                                  .myUserdata['buddyList']
                                                  .contains(userData[0].uid)
                                              ? InkWell(
                                                  onTap: () {
                                                    Provider.of<AuthPro>(
                                                            context,
                                                            listen: false)
                                                        .addBuddy(false, false,
                                                            userData[0].uid);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: themewhitecolor
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: themeblackcolor
                                                              .withOpacity(0.5),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.person_off_outlined,
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Provider.of<AuthPro>(
                                                            context,
                                                            listen: false)
                                                        .addBuddy(true, true,
                                                            userData[0].uid);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: themewhitecolor
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: themeblackcolor
                                                              .withOpacity(0.5),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.person_add_alt_1,
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                );
                                        })),

                                        //video cam
                                        InkWell(
                                          onTap: () {
                                            // final post = Provider.of<CallPro>(
                                            //     context,
                                            //     listen: false);

                                            //   post.createCall(
                                            //       userData[0].uid, context);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: themewhitecolor
                                                  .withOpacity(0.5),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: themeblackcolor
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.videocam,
                                              color: themewhitecolor,
                                            ),
                                          ),
                                        ),
                                        Consumer<AuthPro>(builder:
                                            ((context, modelValue, child) {
                                          return modelValue
                                                  .myUserdata['blockList']
                                                  .contains(userData[0].uid)
                                              ? InkWell(
                                                  onTap: () {
                                                    Provider.of<AuthPro>(
                                                            context,
                                                            listen: false)
                                                        .blockUser(false,
                                                            userData[0].uid);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: themewhitecolor
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: themeblackcolor
                                                              .withOpacity(0.5),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .remove_circle_outline_outlined,
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Provider.of<AuthPro>(
                                                            context,
                                                            listen: false)
                                                        .blockUser(true,
                                                            userData[0].uid);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: themewhitecolor
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: themeblackcolor
                                                              .withOpacity(0.5),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.block,
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                );
                                        })),

                                        //block
                                        // Consumer<AuthPro>(builder:
                                        //     ((context, modelValue, child) {
                                        //   return modelValue.get_blockList
                                        //           .contains(userData[0].uid)
                                        //       ? InkWell(
                                        //           onTap: () {
                                        //             final post =
                                        //                 Provider.of<AuthPro>(
                                        //                     context,
                                        //                     listen: false);
                                        //             post.blockUnblockUserToBlockListFunc(
                                        //                 1, userData[0].uid);
                                        //           },
                                        //           child: Container(
                                        //             height: 50,
                                        //             width: 50,
                                        //             decoration: BoxDecoration(
                                        //               color: themewhitecolor
                                        //                   .withOpacity(0.5),
                                        //               shape: BoxShape.circle,
                                        //               boxShadow: [
                                        //                 BoxShadow(
                                        //                   color: themeblackcolor
                                        //                       .withOpacity(0.5),
                                        //                   blurRadius: 10,
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             child: const Icon(
                                        //               Icons
                                        //                   .remove_circle_outline_outlined,
                                        //               color: themewhitecolor,
                                        //             ),
                                        //           ),
                                        //         )
                                        //       : InkWell(
                                        //           onTap: () {
                                        //             report(
                                        //                 size, userData[0].uid);
                                        //           },
                                        //           child: Container(
                                        //             height: 50,
                                        //             width: 50,
                                        //             decoration: BoxDecoration(
                                        //               color: themewhitecolor
                                        //                   .withOpacity(0.5),
                                        //               shape: BoxShape.circle,
                                        //               boxShadow: [
                                        //                 BoxShadow(
                                        //                   color: themeblackcolor
                                        //                       .withOpacity(0.5),
                                        //                   blurRadius: 10,
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             child: const Icon(
                                        //               Icons.block,
                                        //               color: themewhitecolor,
                                        //             ),
                                        //           ),
                                        //         );
                                        // })),
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 30,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Container(
                                      width: size.width,
                                      height: size.height / 100 * 63,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: themewhitecolor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          messages(userData[0].uid),
                                          //write message here
                                          bottomWidget(userData[0].uid)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget bottomWidget(String oppister_uid) {
    return Form(
      key: _formkey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextFormField(
          controller: _msg_controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: themewhitecolor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            alignLabelWithHint: true,
            label: IntrinsicHeight(
              child: Row(
                children: [
                  CustomIconButton(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: Palette.themecolor,
                    ),
                  ),
                  const VerticalDivider(
                    width: 25,
                  ),
                  const Text(
                    "Write your message here..",
                  ),
                ],
              ),
            ),
            hintText: "Write your message here..",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIconButton(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    final post = Provider.of<ChatPro>(context, listen: false);

                    post.send_text_message(
                        oppister_uid, _msg_controller.text, context);
                    _msg_controller.clear();
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.send,
                    color: themewhitecolor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
      ),
    );
  }

  Stream<List<inner_message_model>> filter_chats(String oppister_uid) =>
      FirebaseFirestore.instance
          .collection("chats")
          .doc(
              get_chat_id(oppister_uid, FirebaseAuth.instance.currentUser!.uid))
          .collection("messages")
          .orderBy('date_time', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => inner_message_model.fromJson(doc.data()))
              .toList());
  Widget messages(String oppister_uid) {
    return StreamBuilder<List<inner_message_model>>(
        stream: filter_chats(oppister_uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final datamodel = snapshot.data!;
            return Expanded(
              child: datamodel.isEmpty
                  ? Center(
                      child: Image.asset(
                      "assets/images/png/no_reels.png",
                      height: 100,
                      width: 100,
                    ))
                  : SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: datamodel.length,
                          itemBuilder: ((context, index) {
                            final model = datamodel[index];
                            return model.type == 0
                                ? text_messages(
                                    oppister_uid,
                                    model.sender_id ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                    model.msg,
                                    model.date_time,
                                    model.seen,
                                    model.message_id,
                                    datamodel.length,
                                    index,
                                  )
                                : model.type == 1
                                    ? image_widget(
                                        oppister_uid,
                                        model.sender_id ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                        model.msg,
                                        index)
                                    : Container();
                          })),
                    ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget text_messages(
    String oppister_uid,
    bool isMe,
    text,
    Timestamp datetime,
    List seen,
    message_id,
    int length,
    int index,
  ) {
    if (seen.length == 1) {
      final post = Provider.of<ChatPro>(context, listen: false);
      post.addseen(oppister_uid, message_id);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: isMe
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.themecolor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: themeblackcolor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: themegreycolor.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: themeblackcolor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget image_widget(String oppister_uid, bool isMe, text, index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          // RouteNavigator.route(
          //     context,
          //     Image.network(
          //       text,
          //       fit: BoxFit.contain,
          //     ));
        },
        child: isMe
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: size.width / 100 * 50,
                  padding: const EdgeInsets.symmetric(
                    vertical: 120,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(text),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width / 100 * 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 150,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(text),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  index == (0)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        oppister_uid, "🧡", context);
                                  },
                                  child: const Text(
                                    "🧡",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        oppister_uid, "👍", context);
                                  },
                                  child: const Text(
                                    "👍",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        oppister_uid, "😂", context);
                                  },
                                  child: const Text(
                                    "😂",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        oppister_uid, "😍", context);
                                  },
                                  child: const Text(
                                    "😍",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        oppister_uid, "😡", context);
                                  },
                                  child: const Text(
                                    "😡",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
      ),
    );
  }

  Stream<List<AuthM>> getBuddyById() => FirebaseFirestore.instance
      .collection(Database.auth)
      .where('uid', isEqualTo: widget.id)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => AuthM.fromJson(document.data()))
          .toList());

  Future<Object?> report(size, String userId) {
    int value = 1;
    return 
    showAnimatedDialog(
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
          titlePadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      Text(
                        "Report",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Why do you want to report this?",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Help us better understand the reason for this report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themegreytextcolor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),

                RadioListTile(
                  value: 1,
                  groupValue: value,
                  onChanged: (int? valueOne) {
                    setState(
                      () {
                        value = valueOne!;
                      },
                    );
                    log("Selected Value: $value");
                  },
                  title: const Text(
                    "I Just don't like it",
                  ),
                  activeColor: Palette.themecolor,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: value,
                  onChanged: (int? valueTwo) {
                    setState(
                      () {
                        value = valueTwo!;
                      },
                    );
                    log("Selected Value: $value");
                  },
                  title: const Text(
                    "It's spam",
                  ),
                  activeColor: Palette.themecolor,
                ),
                RadioListTile(
                  value: 3,
                  groupValue: value,
                  onChanged: (int? valueThree) {
                    setState(
                      () {
                        value = valueThree!;
                      },
                    );
                    log("Selected Value: $value");
                  },
                  title: const Text(
                    "Inappropiate Language",
                  ),
                  activeColor: Palette.themecolor,
                ),
                RadioListTile(
                  value: 4,
                  groupValue: value,
                  onChanged: (int? valueFour) {
                    setState(
                      () {
                        value = valueFour!;
                      },
                    );
                    log("Selected Value: $value");
                  },
                  title: const Text(
                    "False Information",
                  ),
                  activeColor: Palette.themecolor,
                ),
                RadioListTile(
                  value: 5,
                  groupValue: value,
                  onChanged: (int? valueFive) {
                    setState(
                      () {
                        value = valueFive!;
                      },
                    );
                    log("Selected Value: $value");
                  },
                  title: const Text(
                    "Bullying or Harassement",
                  ),
                  activeColor: Palette.themecolor,
                ),

                // Column(
                //   children: List.generate(
                //     5,
                //     (index) => Column(
                //       children: const [
                //         Divider(
                //           height: 0,
                //         ),
                //         ListTile(
                //           minVerticalPadding: 0,
                //           title: Text("I Just don't like it"),
                //           trailing: Icon(
                //             Icons.arrow_forward_ios,
                //             size: 18,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const Divider(
                  height: 0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextButton(
                        buttonText: "Skip",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        textstyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomElevatedButton(
                        onTap: () {
                          Navigator.pop(context);
                          final post =
                              Provider.of<AuthPro>(context, listen: false);
                          // post.blockUnblockUserToBlockListFunc(0, userId);
                          reportConfirmation(size);
                        },
                        buttonSize: const Size(100, 35),
                        buttoncolor: themelightgreencolor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: const Text("Submit"),
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

  
  Future<Object?> reportConfirmation(size) {
    return 
    showAnimatedDialog(
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
          titlePadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: SizedBox(
            width: size.width,
            child: Column(
              children: [
                const Text(
                  "Report",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: themelightgreencolor,
                  size: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Thanks for reporting this!",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "We will review the post to determine if it violates our policies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themegreytextcolor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Thank you for helping make Mended a safe place",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themegreytextcolor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CustomTextButton(
                    buttonText: "Got it",
                    onTap: () {
                      Navigator.pop(context);
                    },
                    textstyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
